{ den, ... }:
{
  den.aspects.messaging._.messenger = {
    # The default sub-aspect included when the generic 'messenger' sub-aspect is used
    includes = with den.aspects.messaging._.messenger._; [ caprine ];
  };
}
