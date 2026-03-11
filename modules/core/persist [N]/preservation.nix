# Ephemeral state management
# https://nix-community.github.io/preservation/configuration-options.html

# This aspect should be imported into any host that wants ephemeral storage
# Like so: `den.aspects.<host>.includes = [ den.aspects.persist ];`

{ inputs, den, lib, ... }: let
  # ---Class factories---
  # Factory to generate system-level custom classes
  mkSystemClass = { fromClass, intoPath }:
    { class, aspect-chain }: den.provides.forward {
      each = lib.singleton true;
      fromClass = _: fromClass;
      intoClass = _: "nixos"; # Preservation only supports NixOS
      intoPath = _: intoPath;
      fromAspect = _: lib.head aspect-chain;
      guard = { options, ... }@osArgs: options ? preservation;
      adaptArgs = args: args // { osConfig = args.config; };
    };

  # Factory to generate user-level custom classes
  mkUserClass = { fromClass, intoSubPath }:
    { host, user }: { class, aspect-chain }: den.provides.forward {
      each = lib.singleton user;
      fromClass = _: fromClass;
      intoClass = _: "nixos"; # Preservation only supports NixOS
      intoPath = u: [ "my" "preservation" intoSubPath u.userName ];
      fromAspect = _: lib.head aspect-chain;
      guard = { options, ... }@osArgs: options ? preservation;
      adaptArgs = { config, ... }@args: args // {
        hmConfig = config.home-manager.users.${user.userName};
      };
    };

  # ---Class definitions---
  # System level `persist` class for declaring preservation config
  persistClass = mkSystemClass {
    fromClass = "persist";
    intoPath = [ "preservation" "preserveAt" "/persist" ];
  };
  # User level `persist` class for declaring preservation config within home-manager
  persistTmpClass = mkSystemClass {
    fromClass = "persistTmp";
    intoPath = [ "my" "preservation" "tmpfiles" ];
  };
  # System level `tmpfiles` class for declaring `systemd.tmpfiles` cleanly
  persistIgnoreClass = mkSystemClass {
    fromClass = "persistIgnore";
    intoPath = [ "my" "preservation" "ignore" ];
  };
  # User level `tmpfiles` class for declaring `systemd.tmpfiles` config within home-manager
  persistUserClass = mkUserClass {
    fromClass = "persistUser";
    intoSubPath = "persistUser";
  };
  # System level `tmpfiles` class for declaring `systemd.tmpfiles` cleanly
  persistUserTmpClass = mkUserClass {
    fromClass = "persistUserTmp";
    intoSubPath = "userTmpfiles";
  };
  # System level `tmpfiles` class for declaring `systemd.tmpfiles` cleanly
  persistUserIgnoreClass = mkUserClass {
    fromClass = "persistUserIgnore";
    intoSubPath = "userIgnore";
  };

in {
  # Flake inputs
  flake-file.inputs.preservation = {
    url = "github:nix-community/preservation";
  };

  # TODO: Move to `den.ctx.hm-user.includes` after `hm-user` is fixed upstream
  # Register the user persist classes
  den.ctx.user.includes = [
    persistUserClass
    persistUserTmpClass
    persistUserIgnoreClass
  ];

  den.aspects.persist = {
    # Register the system persist classes
    includes = [
      persistClass
      persistTmpClass
      persistIgnoreClass
    ];

    nixos = { config, lib, ... }: {
      # Import the preservation module
      imports = [ inputs.preservation.nixosModules.preservation ];

      # Declare options for intermediate variable storage
      options.my.preservation = with lib.types; {
        persistUser = lib.mkOption {
          type = attrsOf (attrsOf anything);
          default = {};
        };
        userTmpfiles = lib.mkOption {
          type = attrsOf (attrsOf anything);
          default = {};
        };
        userIgnore = lib.mkOption {
          type = attrsOf (attrsOf anything);
          default = {};
        };
        tmpfiles = lib.mkOption {
          type = attrsOf anything;
          default = {};
        };
        ignore = lib.mkOption {
          type = attrsOf (listOf anything);
          default = {};
        };
      };

      config = let
        # ---Shared helper functions---
        getHome = userName: config.home-manager.users.${userName}.home.homeDirectory;

        mkAbsolute = userName: path:
          if lib.hasPrefix "/" path then
            path                           # Return absolute paths untouched
          else
            "${getHome userName}/${path}"; # Prepend homeDir to relative paths

        mkRelative = userName: path:
          if builtins.isString path then
            lib.removePrefix "${getHome userName}/" path # Strip homeDir from absolute paths
          else
            path;                                        # Return relative paths untouched

      in {
        preservation.enable = true; # Enable the module

/*  Intercept and transform the output of `persistUser` before it reaches `preservation`
    It takes:
      persistUser = { hmConfig, ... }: {
        directories = [
          "${hmConfig.xdg.configHome}/sops"
          { directory = "userdir/subdir"; mode = "0600"; }
        ];
      };
    And transforms it to:
      preservation.preserveAt."/persist".users.<user> = {
        directories = [
          ".config/sops"
          { directory = "userdir/subdir"; mode = "0600"; }
        ];
      };
    "${hmConfig.xdg.configHome}" would normally become "/home/<user>/.config" which preservation
    would translate into "/home/<user>/home/<user>/.config" as it expects relative paths */
        preservation.preserveAt."/persist".users = lib.mapAttrs (userName: rawConfig:
          let
            transform = val:
              if builtins.isList val then map transform val
              else if builtins.isAttrs val then
                lib.mapAttrs (key: value:
                  if key == "directory" || key == "file" then
                    mkRelative userName value
                  else
                    transform value
                ) val
              else
                mkRelative userName val;
          in transform rawConfig
        ) config.my.preservation.persistUser;
        
/*  Intercept and transform the output of `persistTmp` and `persistUserTmp`
    before it reaches `systemd.tmpfiles.settings.preservation`
    It takes:
      "/dir/subdir" = { };
      "relative/user/dir" = { };
      "${hmConfig.xdg.configHome}/foo" = { mode = "0600"; };
    And transforms it to:
      "/dir/subdir".d = { user = "root"; group = "root"; mode = "0755"; };
      "/home/<user>/relative/user/dir".d = { user = "<user>"; group = "users"; mode = "755"; };
      "/home/<user>/.config/foo".d = { user = "<user>"; group = "users"; mode = "0600"; }; */
        systemd.tmpfiles.settings.preservation = lib.mkMerge [
          # System
          (lib.mapAttrs' (path: opts:
            lib.nameValuePair path {
              d = { user = "root"; group = "root"; mode = "0755"; } // opts;
            }
          ) config.my.preservation.tmpfiles)
          
          # User
          (lib.mkMerge (lib.mapAttrsToList (userName: rawConfig:
            let
              group = config.users.users.${userName}.group or "users";
            in
            lib.mapAttrs' (path: opts:
              lib.nameValuePair (mkAbsolute userName path) {
                d = { user = userName; inherit group; mode = "0755"; } // opts;
              }
            ) rawConfig
          ) config.my.preservation.userTmpfiles))
        ];

/*  Transform the output of `persistUserIgnore` and merge it with `persistIgnore`
    for easier use parsing into the `find-ephemeral` tool
    It takes:
      <user> = {
        directories = [ "user/dir" ];
        files = [ "/home/<user>/.config/file.ext" ];
      };
    And transforms it to:
      directories = [ "/home/<user>/user/dir" ];
      files = [ "/home/<user>/.config/file.ext" ]; */
        my.preservation.ignore = let
          getTransformedUserPaths = pathType:
            lib.concatLists (lib.mapAttrsToList (userName: userConfig:
              map (mkAbsolute userName) (userConfig.${pathType} or [])
            ) config.my.preservation.userIgnore);
        in {
          directories = getTransformedUserPaths "directories";
          files       = getTransformedUserPaths "files";
        };
      };
    };
  };
}