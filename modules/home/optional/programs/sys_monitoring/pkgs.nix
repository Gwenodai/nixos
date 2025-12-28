{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
  ];
}