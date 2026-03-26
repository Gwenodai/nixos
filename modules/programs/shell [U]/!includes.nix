{ den, lib, ... }: {
  den.aspects.shell = {
    # All sub-aspects are included when the generic 'shell' aspect is used
    includes = lib.attrValues den.aspects.shell._;
  };
}