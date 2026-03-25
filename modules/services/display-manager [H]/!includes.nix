{ den, ... }: {
  den.aspects.display-manager = {
    # The default sub-aspect included when the generic 'display-manager' aspect is used
    includes = with den.aspects.display-manager._; [ gdm ];
  };
}
