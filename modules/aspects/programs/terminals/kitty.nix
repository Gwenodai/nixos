# https://mynixos.com/home-manager/options/programs.kitty
{ lib, ... }:
{
  den.aspects.kitty = {
    meta = {
      category = "terminal";
      binPath = pkgs: "${lib.getExe pkgs.kitty}";
    };

    homeManager =
      {
        host,
        lib,
        ...
      }:
      {
        programs.kitty = {
          enable = true;

          enableGitIntegration = true;
          shellIntegration = {
            enableZshIntegration = true;
            enableBashIntegration = true;
          };

          settings = {
            ### `auto_reload_config` must be set to a negative value
            # This prevents kitty from using up all the systems ionotify watches
            auto_reload_config = -1;
            background_blur = 1;
            scrollback_lines = 10000;
            update_check_interval = 0;
          };
        };

        # Custom aliases
        home.shellAliases = {
          ssh = "kitty +kitten ssh";
        };

        xdg = {
          terminal-exec = {
            enable = true;
            settings = {
              default = [
                "kitty.desktop"
              ];
            };
          };

          mimeApps = {
            defaultApplications =
              let
                application = "kitty-open.desktop";
                mimeTypes = [
                  "image/*"
                  "application/x-sh"
                  "application/x-shellscript"
                  "inode/directory"
                  "text/*"
                  "x-scheme-handler/kitty"
                  "x-scheme-handler/ssh"
                ];
              in
              lib.genAttrs mimeTypes (_: application);
          };
        };
      };

    ### Persist config
    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.cache/kitty"
          "${hmConfig.xdg.cacheHome}/kitty"
        ];
      };
  };
}
