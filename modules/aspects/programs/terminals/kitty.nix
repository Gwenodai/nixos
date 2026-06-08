# https://mynixos.com/home-manager/options/programs.kitty
{ lib, ... }:
{
  den.aspects.terminal-kitty = {
    meta = {
      pkgBinPath = pkgs: "${lib.getExe pkgs.kitty}";
    };

    homeManager =
      {
        host,
        pkgs,
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
            defaultApplications = (
              let
                application = "kitty-open.desktop";
                mimeTypes = [
                  "x-scheme-handler/kitty"
                  "x-scheme-handler/ssh"
                ];
              in
              lib.genAttrs mimeTypes (mimetype: application)
            );

            associations.added =
              let
                application = "kitty-open.desktop";
                mimeTypes = [
                  "application/x-sh"
                  "application/x-shellscript"
                  "inode/directory"
                  "image/*"
                  "text/*"
                ];
              in
              lib.genAttrs mimeTypes (mimetype: application);
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
