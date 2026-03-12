{ den, ... }: {
  den.aspects.system-type = {

    provides.basic = {
      includes = with den.aspects; [
        nix-config
        firmware
        kernel
        ssh
        cli
        xdg
      ];
    };

    provides.desktop = {
      includes = with den.aspects; [
        system-type.provides.basic
        audio
        keyring
        polkit
        display-manager
      ];
    };
  };
}
