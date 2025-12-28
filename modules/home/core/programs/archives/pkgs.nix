{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    zip
    xz
    unzip
    p7zip
    gnutar
  ];
}