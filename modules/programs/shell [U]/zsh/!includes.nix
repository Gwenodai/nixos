{ den, ... }: {
  den.aspects.shell._.zsh = {
    # Bundles all zsh components when the complete 'zsh' sub-aspect is used
    includes = with den.aspects.shell._.zsh._; [
      enable
      config
    ];
  };
}