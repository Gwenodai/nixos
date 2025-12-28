{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    ripgrep # recursively searches directories for a regex pattern
    eza # A modern replacement for ‘ls’
    bat # Better cat with syntax highlighting
  ];
}