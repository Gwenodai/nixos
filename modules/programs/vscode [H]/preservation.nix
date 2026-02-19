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
      host.preservation = {
        preserveAt."/persist" = {
          directories = [
            "${config.xdg.configHome}/Code/User"
          ];
          files = [
            {
              file = "${config.xdg.configHome}/Code/Trust Tokens";
              mode = "0600";
            }
            {
              file = "${config.xdg.configHome}/Code/Trust Tokens-journal";
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