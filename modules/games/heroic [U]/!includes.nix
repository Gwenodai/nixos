{ den, ... }:
{
  den.aspects.heroic = {
    # All sub-aspects are included when the generic 'heroic' aspect is used
    includes = with den.aspects.heroic._; [
      enable
      config
    ];
  };
}
