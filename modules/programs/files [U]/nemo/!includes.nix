{ den, ... }: {
  den.aspects.files = {
    # Bundles all nemo components when the complete 'nemo' sub-aspect is used
    includes = with den.aspects.files._.nemo._; [
      enable
      config
    ];
  };
}
