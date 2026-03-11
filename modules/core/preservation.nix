# Ephemeral state management
# https://nix-community.github.io/preservation/configuration-options.html
{ inputs, den, lib, ... }: let
  # System level `persist` class for declaring preservation config
  persistClass = { class, aspect-chain }: den.provides.forward {
    each = lib.singleton true;
    fromClass = _: "persist";
    intoClass = _: "nixos"; # Preservation only supports NixOS
    intoPath = _: [ "preservation" "preserveAt" "/persist" ];
    fromAspect = _: lib.head aspect-chain;
    guard = { options, ... }@osArgs: options ? preservation;
    adaptArgs = args: args // { osConfig = args.config; };
  };
  # User level `persist` class for declaring preservation config within home-manager
  persistUserClass = { host, user }: { class, aspect-chain }: den.provides.forward {
    each = lib.singleton user;
    fromClass = _: "persistUser";
    intoClass = _: "nixos"; # Preservation only supports NixOS
    intoPath = u: [ "my" "preservation" "persistUser" u.userName ];
    fromAspect = _: lib.head aspect-chain;
    guard = { options, ... }@osArgs: options ? preservation;
    # Allows access to the home-manager user config within the class
    # via `persistUser = { hmConfig, ... }: {...};`
    adaptArgs = { config, ... }@args: args // {
      hmConfig = config.home-manager.users.${user.userName};
    };
  };

  # System level `tmpfiles` class for declaring `systemd.tmpfiles` cleanly
  persistTmpClass = { class, aspect-chain }: den.provides.forward {
    each = lib.singleton true;
    fromClass = _: "persistTmp";
    intoClass = _: "nixos";
    intoPath = _: [ "my" "preservation" "tmpfiles" ];
    fromAspect = _: lib.head aspect-chain;
    guard = { options, ... }@osArgs: options ? preservation;
    adaptArgs = args: args // { osConfig = args.config; };
  };

  # User level `tmpfiles` class for declaring `systemd.tmpfiles` config within home-manager
  persistUserTmpClass = { host, user }: { class, aspect-chain }: den.provides.forward {
    each = lib.singleton user;
    fromClass = _: "persistUserTmp";
    intoClass = _: "nixos";
    intoPath = u: [ "my" "preservation" "userTmpfiles" u.userName ];
    fromAspect = _: lib.head aspect-chain;
    guard = { options, ... }@osArgs: options ? preservation;
    adaptArgs = { config, ... }@args: args // {
      hmConfig = config.home-manager.users.${user.userName};
    };
  };
in {
  # Flake inputs
  flake-file.inputs.preservation = {
    url = "github:nix-community/preservation";
  };

  # TODO: Move to `den.ctx.hm-user.includes` after `hm-user` is fixed upstream
  den.ctx.user.includes = [ persistUserClass persistUserTmpClass ]; # Register the `persistUser` class

  den.aspects.persist = {
    includes = [ persistClass persistTmpClass ]; # Register the `persist` class  
    nixos = { config, lib, ... }: {
      # Import the preservation module
      imports = [ inputs.preservation.nixosModules.preservation ];

      options.my.preservation = {
        persistUser = lib.mkOption {
          type = lib.types.attrsOf (lib.types.attrsOf lib.types.anything);
          default = {};
          description = "Intermediate holding ground for persistUser configurations.";
        };
        tmpfiles = lib.mkOption {
          type = lib.types.attrsOf lib.types.anything;
          default = {};
        };
        userTmpfiles = lib.mkOption {
          type = lib.types.attrsOf (lib.types.attrsOf lib.types.anything);
          default = {};
        };
      };
      config = {
        preservation.enable = true; # Enable the module

        /* Intercept and transform the output of `persistUser` before it reaches `preservation`
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
          let # `homePrefix` evaluates to "/home/<user>/" (usually)
            homePrefix = "${config.home-manager.users.${userName}.home.homeDirectory}/";
            # Removes `homePrefix` from the start of strings which contain it
            strip = input:
              if builtins.isString input then     # If input is a string
                lib.removePrefix homePrefix input # Strip the prefix
              else
                input;                            # Otherwise return as-is
            # Recursively walks through `rawConfig` processing values appropriately
            transform = val:
              if builtins.isList val then # `directories = [...]`
                map transform val         # Feed the contents of the list back to `transform`
              else if builtins.isAttrs val then # `{ directory = "..."; mode = "..."; }`
                lib.mapAttrs (key: value: 
                  if key == "directory" || key == "file" then # `directory = "..."`
                    strip value     # Use `strip` to sanitise value for the preservation module
                  else
                    transform value # Feed it through `transform` again
                ) val
              else         # Catch-all for simple string paths in lists ("foo/bar.sh")
                strip val; # Use `strip` to sanitise value for the preservation module
          in
            transform rawConfig # `rawConfig` = `{ directories = [...]; files = [...]; }`
        ) config.my.preservation.persistUser; # Intermediate `persistUser` config location
        
        /* Intercept and transform the output of `persistTmp` and `persistUserTmp`
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
          # System level tmpfiles config (aka `persistTmp`)
          (lib.mapAttrs' (path: opts: 
            lib.nameValuePair path { # Set default tmpfiles options
              d = { user = "root"; group = "root"; mode = "0755"; } // opts; # Merge supplied opts
            }
          ) config.my.preservation.tmpfiles) # Intermediate `tmpfiles` config location
          # User level tmpfiles config (aka `persistUserTmp`)
          (lib.mkMerge (lib.mapAttrsToList (userName: rawConfig:
            let
              homeDir = config.home-manager.users.${userName}.home.homeDirectory;
              # Fallback to "users" group if the user's primary group isn't defined
              group = config.users.users.${userName}.group or "users";
              # Convert relative paths to absolute paths
              makeAbsolute = path: 
                if lib.hasPrefix "/" path then # Prepend home directory only if the
                  path                         # path is relative (doesn't start with "/")
                else
                  "${homeDir}/${path}";
            in
              lib.mapAttrs' (path: opts:
                lib.nameValuePair (makeAbsolute path) {
                  # Derive and set default tmpfiles options
                  d = { user = userName; inherit group; mode = "0755"; } // opts; # Merge supplied opts
                }
              ) rawConfig # `rawConfig` = `"/dir/subdir" = { }; "/foo/bar" = { mode = "0600"; };`
          ) config.my.preservation.userTmpfiles)) # Intermediate `userTmpfiles` config location
        ];
      };
    };
  };

  # All aspects below are temporary persist testing aspects
  den.aspects.foo = {
    homeManager.xdg.enable = lib.mkDefault true;
    
    persist = {
      directories = [
        { directory = "/var/lib/nixos"; inInitrd = true; }
      ];
      files = [
        {
          file = "/etc/machine-id";
          how = "symlink";
          inInitrd = true;
          configureParent = true;
        }
      ];
    };

    persistUser = { hmConfig, ... }: {
      directories = [
        { directory = "userdir/foo"; mode = "0600"; }
      ];
      files = [
        "userfile/bar.file"
        "${hmConfig.xdg.configHome}/sops"
      ];
    };

    persistTmp = {
      "/foo/bar/dir" = { };
    };

    persistUserTmp = { hmConfig, ... }: {
      "${hmConfig.xdg.configHome}/foo/bar" = { mode = "0700"; };
      "${hmConfig.xdg.configHome}/foo" = { mode = "0700"; };
      "${hmConfig.xdg.configHome}" = { };
      
      "Documents/PersistTest" = { mode = "0700"; }; 
    };
  };
  den.aspects.gwen-t1.includes = [ den.aspects.persist ]; # Host
  den.aspects.gwen.includes = [ den.aspects.foo ]; # User
}