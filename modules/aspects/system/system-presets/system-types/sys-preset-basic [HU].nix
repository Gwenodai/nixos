# Preset system types.
# These should be imported by BOTH hosts and users wanting to use them.
{ den, ... }:
let
  basic = {
    includes = with den.aspects; [
      # ---Core Config--- #
      secrets
      nix-config
      firmware
      xdg

      # ---Basic Tools--- #
      coolercontrol
      ssh
      cli
      git

      # ---Shells--- #
      zsh
      bash
      starship
    ];
  };
in
{
  den.aspects.sys-preset-basic.includes = [ basic ];
}
