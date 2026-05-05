# https://mynixos.com/home-manager/options/programs.kitty
{ den, ... }:
{
  den.aspects.kitty = den.lib.perUser {
    homeManager =
      { pkgs, lib, ... }:
      {
        programs.kitty = {
          enable = true;

          shellIntegration = {
            enableZshIntegration = true;
            enableBashIntegration = true;
          };
          enableGitIntegration = true;
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

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [ "${hmConfig.xdg.cacheHome}/kitty" ];
      };
  };
}
