{ den, ... }: {
  den.aspects.terminal = {
    includes = with den.aspects.terminal._; [ kitty ];
    
    # https://mynixos.com/home-manager/options/programs.kitty
    _.kitty = den.lib.perUser {
      homeManager = { pkgs, lib, ... }: {
        programs.kitty = {
          enable = lib.mkDefault true;

          shellIntegration = {
            enableZshIntegration = lib.mkDefault true;
            enableBashIntegration = lib.mkDefault true;
          };
          enableGitIntegration = lib.mkDefault true;
        };

        # Custom aliases
        home.shellAliases = {
          ssh = lib.mkDefault "kitty +kitten ssh";
        };

        xdg = {
          terminal-exec = {
            enable = true;
            settings = {
              default = lib.mkBefore [
                "kitty.desktop"
              ];
            };
          };
          mimeApps = {
            defaultApplications = lib.mkBefore (
              let
                application = "kitty-open.desktop";
                mimeTypes = [
                  "x-scheme-handler/kitty"
                  "x-scheme-handler/ssh"
                ];
              in lib.genAttrs mimeTypes (mimetype: application)
            );
            associations.added = let
              application = "kitty-open.desktop";
              mimeTypes = [
                "application/x-sh"
                "application/x-shellscript"
                "inode/directory"
                "image/*"
                "text/*"
              ];
            in lib.genAttrs mimeTypes (mimetype: application);
          };
        };
      };

      persistUserIgnore = { hmConfig, ... }: {
        directories = [ "${hmConfig.xdg.cacheHome}/kitty" ];
      };
    };
  };
}
