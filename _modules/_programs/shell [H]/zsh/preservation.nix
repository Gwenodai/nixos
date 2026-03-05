{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.shell = {
    options,
    config,
    lib,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        preserveAt."/persist" = {
          files = [
            {
              file = "${config.xdg.configHome}/zsh/.zsh_history";
              mode = "0600";
            }
          ];
        };
        setupDirectories = {
          "${config.xdg.configHome}" = { }; # "~/.config"
          "${config.xdg.configHome}/zsh" = { };
        };
        
        ignore.files = [
          "${config.xdg.configHome}/zsh/.zcompdump"
        ];
      };
    };
  };
}