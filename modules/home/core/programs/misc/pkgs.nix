{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    file
    which
    tree
    gnused
    gawk
  ];
}