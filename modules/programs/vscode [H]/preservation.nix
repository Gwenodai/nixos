{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    options,
    config,
    lib,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      preservation = let
        relativeToHome = path: lib.removePrefix (config.home.homeDirectory + "/") path;
      in {
        preserveAt."/persist" = {
          directories = [
            "${relativeToHome config.xdg.configHome}/Code/User"
          ];
          files = [
            {
              file = "${relativeToHome config.xdg.configHome}/Code/Trust Tokens";
              mode = "0600";
            }
            {
              file = "${relativeToHome config.xdg.configHome}/Code/Trust Tokens-journal";
              mode = "0600";
            }
          ];
        };
        
        setupDirectories = {
          "${config.xdg.configHome}" = { };
          "${config.xdg.configHome}/Code" = { };
        };

        ignore = {
          directories = [
            "${config.xdg.configHome}/Code"
            "${config.xdg.cacheHome}/fontconfig"
          ];
          files = [
            "${config.xdg.cacheHome}/Microsoft/DeveloperTools/deviceid"
            ".vscode/extensions/extensions.json"
            ".vscode/argv.json"
          ];
        };
      };
    };
  };
}