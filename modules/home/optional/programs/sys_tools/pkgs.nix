{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];
}