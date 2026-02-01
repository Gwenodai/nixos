{
  inputs,
  ...
}: {
  flake.modules.homeManager.shell = {
    config,
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
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
}