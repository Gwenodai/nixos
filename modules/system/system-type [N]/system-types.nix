# Preset system types. These should only be imported by hosts not users
# Like so: `den.aspects.<host>.includes = [ den.aspects.system-type.provides.<type> ];`
{ den, ... }: {
  den.aspects.system-type = {

    provides.basic = {
      includes = with den.aspects; [
        nix-config
        hardware.provides.firmware
        kernel
        ssh
        cli
        xdg
      ];
    };

    provides.desktop = {
      includes = with den.aspects; [
        system-type.provides.basic
        display-manager
        keyring
        polkit
        audio
      ];
    };
  };
}
