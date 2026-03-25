{ den, ... }: {
  den.aspects.coolercontrol = {
    # All sub-aspects are included when the generic 'coolercontrol' aspect is used
    includes = with den.aspects.coolercontrol._; [
      enable
      class
    ];
  };
}
