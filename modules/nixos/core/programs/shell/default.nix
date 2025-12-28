{
  pkgs,
  ...
}:

{
  imports = [
      ./bash
      # ./zsh
  ];

  # Set default user shell to zsh
  # users.defaultUserShell = pkgs.zsh;
}