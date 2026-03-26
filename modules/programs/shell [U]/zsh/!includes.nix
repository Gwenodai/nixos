{ den, lib, ... }: {
  den.aspects.shell._.zsh = {
    # Bundles all zsh components when the complete 'zsh' sub-aspect is used
    includes = lib.attrValues den.aspects.shell._.zsh._;
  };
}