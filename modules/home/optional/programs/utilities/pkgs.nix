{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    jq # A lightweight and flexible command-line JSON processor
  ];
}