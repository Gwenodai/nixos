{ den, ... }: {
  den.aspects.persist.provides.transformers = den.lib.take.exactly ({ host }: {
    nixos = { config, lib, ... }: {
      config = let
        # ---Path sanitising helpers--- #
        getHome = userName: config.home-manager.users.${userName}.home.homeDirectory;

        # Prepend homeDir to relative paths, return absolute paths untouched
        mkAbsolute = userName: path:
          if lib.hasPrefix "/" path then
            path
          else
            "${getHome userName}/${path}";

        # Strip homeDir from absolute paths, return relative paths untouched
        mkRelative = userName: path:
          if lib.isString path then
            lib.removePrefix "${getHome userName}/" path
          else
            path;

      # ---Config transformers--- #
      in {
  /*  Intercept and transform the output of `userPersist` before it reaches `preservation`
    It takes:
      userPersist = { hmConfig, ... }: {
        directories = [
          "${hmConfig.xdg.configHome}/dir"
          { directory = "userdir/subdir"; mode = "0600"; }
        ];
      };
    And transforms it to:
      preservation.preserveAt."/persist".users.<user> = {
        directories = [
          ".config/dir"
          { directory = "userdir/subdir"; mode = "0600"; }
        ];
      };
    "${hmConfig.xdg.configHome}" would normally become "/home/<user>/.config" which preservation
    would translate into "/home/<user>/home/<user>/.config" as it expects relative paths */
        preservation.preserveAt."/persist".users = lib.mapAttrs (userName: rawConfig:
          let
            transform = val:
              if lib.isList val then map transform val
              else if lib.isAttrs val then
                lib.mapAttrs (key: value:
                  if key == "directory" || key == "file" then
                    mkRelative userName value
                  else
                    transform value
                ) val
              else
                mkRelative userName val;
          in transform rawConfig
        ) config.my.preservation.userPersist;
        
  /*  Intercept and transform the output of `persistTmp` and `persistUserTmp`
    before it reaches `systemd.tmpfiles.settings.preservation`
    It takes:
      "/dir/subdir" = {};
      "relative/user/dir" = {};
      "${hmConfig.xdg.configHome}/foo" = { mode = "0600"; };
    And transforms it to:
      "/dir/subdir".d = { user = "root"; group = "root"; mode = "0755"; };
      "/home/<user>/relative/user/dir".d = { user = "<user>"; group = "users"; mode = "755"; };
      "/home/<user>/.config/foo".d = { user = "<user>"; group = "users"; mode = "0600"; }; */
        systemd.tmpfiles.settings.preservation = lib.mkMerge [
          # System
          (lib.mapAttrs (path: opts: {
            d = { user = "root"; group = "root"; mode = "0755"; } // opts;
          }) config.my.preservation.tmpfiles)
          
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
      # Options for intermediate config storage
      options.my.preservation = with lib.types; {
        userPersist = lib.mkOption {
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
    };
  });
}