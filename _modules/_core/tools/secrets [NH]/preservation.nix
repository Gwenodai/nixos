{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.secrets = {
    options,
    config,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        preserveAt."/persist" = {
          directories = [
            "${config.xdg.configHome}/sops"
          ];
        };
        
        setupDirectories = {
          "${config.xdg.configHome}" = { }; # "~/.config"
        };
      };
    };
  };
}