{ den, ... }: {
  den.aspects.messaging._.discord = {
    # The default sub-aspect included when the generic 'discord' sub-aspect is used
    includes = with den.aspects.messaging._.discord._; [ vesktop ];
  };
}
