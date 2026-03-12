{ den, ... }: {
  den.aspects.system-type = {

    provides.cli = {
      includes = with den.aspects; [];
    };

    provides.desktop = {
      includes = with den.aspects; [
        system-type.provides.cli
        audio
        keyring
      ];
    };
  };
}
