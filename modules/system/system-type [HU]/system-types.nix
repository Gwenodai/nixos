# Preset system types. These should only be imported by hosts not users
# Like so: `den.aspects.<host>.includes = [ den.aspects.system-type._.<type> ];`
{ den, ... }: {
  den.aspects.system-type = {

    _.basic = {
      includes = with den.aspects; [
        nix-config
        hardware._.firmware
        kernel
        cli
      ];
    };

    _.desktop = {
      includes = with den.aspects; [
        system-type._.basic
        display-manager
        coolercontrol
        keyring
        polkit
        audio
        fonts
      ];

      _.gaming = {
        includes = with den.aspects; [
          system-type._.desktop
          hardware._.graphics
          lact
        ];
      };
    };
  };
}
