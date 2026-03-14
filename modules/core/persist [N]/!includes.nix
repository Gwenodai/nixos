{ den, ... }: {
  den.aspects.persist = {
    includes = with den.aspects.persist.provides; [
      enable         # Import and enable the preservation module
      classes        # Custom classes to define preservation only configuration
      minimal        # Minimal necessary system level preservation configuration
      find-ephemeral # Simple tool to list unpreserved files
    ];
  };
}