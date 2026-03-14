# Preset system types. These should only be imported by hosts not users
# Like so: `den.aspects.<host>.includes = [ den.aspects.system-type.provides.<type> ];`
{ den, ... }: {
  den.aspects.system-type = {

    _.basic = {
      includes = with den.aspects; [
        nix-config
        hardware._.firmware
        kernel
        ssh
        cli
        xdg
      ];
    };

    _.desktop = {
      includes = with den.aspects; [
        system-type._.basic
        display-manager
        keyring
        polkit
        audio
        fonts
      ];
    };
  };
}
