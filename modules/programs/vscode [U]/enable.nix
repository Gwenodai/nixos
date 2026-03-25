# https://mynixos.com/home-manager/options/programs.vscode
{ den, ... }: {
  den.aspects.vscode._.enable = den.lib.perUser {
    homeManager = { lib, ... }: {
      programs.vscode.enable = lib.mkDefault true;

      xdg.mimeApps.defaultApplications = lib.mkBefore (
        let
          application = "code.desktop";
          mimeTypes = [
            "application/octet-stream"
            "application/x-executable"
            "application/x-object"
            "application/x-shellscript"
            "application/x-zerosize"
            "application/xml"
            "text/css"
            "text/javascript"
            "text/markdown"
            "text/plain"
            "text/x-csrc"
            "text/x-python"
            "text/x-python3"
            "text/csv"
            "text/x-nix"
            "text/plain"
          ];
        in lib.genAttrs mimeTypes (mimetype: application)
      );
    };

    persistUser = { hmConfig, ... }: {
      directories = [
        "${hmConfig.xdg.configHome}/Code/User"
      ];
      files = [
        {
          file = "${hmConfig.xdg.configHome}/Code/Trust Tokens";
          mode = "0600";
        }
        {
          file = "${hmConfig.xdg.configHome}/Code/Trust Tokens-journal";
          mode = "0600";
        }
      ];
    };

    persistUserTmp = { hmConfig, ... }: {
      "${hmConfig.xdg.configHome}" = {}; # "~/.config"
      "${hmConfig.xdg.configHome}/Code" = {};
    };

    persistUserIgnore = { hmConfig, ... }: {
      directories = [
        "${hmConfig.xdg.configHome}/Code"
      ];
      files = [
        "${hmConfig.xdg.cacheHome}/Microsoft/DeveloperTools/deviceid"
        ".vscode/extensions/extensions.json"
        ".vscode/argv.json"
      ];
    };
  };
}
