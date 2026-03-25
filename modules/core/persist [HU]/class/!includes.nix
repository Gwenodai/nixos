{ den, ... }: {
  den.aspects.persist._.class = {
    # Bundles all class components when the complete 'class' sub-aspect is used
    includes = with den.aspects.persist._.class._; [
      classes      # Custom classes to define preservation only configuration
      transformers # Transforms class configs to proper configs
    ];
  };
}