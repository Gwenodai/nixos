{
  flake.modules.homeManager.shell = {
    lib,
    config,
    ...
  }: {
    config = lib.mkIf config.preservation.enable {
      home.preservation = {
        preserveAt."/persist" = {
          files = [
            { file = ".config/zsh/.zsh_history"; mode = "0600"; }
          ];
        };
        setupDirectories = {
          ".config" = { };
          ".config/zsh" = { };
        };
      };
    };
  };
}