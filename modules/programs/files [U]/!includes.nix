{ den, ... }: {
  den.aspects.files = {
    # The default sub-aspect included when the generic 'files' aspect is used
    includes = with den.aspects.files._; [ nemo ];
  };
}
