{ den, lib, ... }:
{
  den.aspects.cli = {
    # All sub-aspects are included when the generic 'cli' aspect is used
    includes = lib.attrValues den.aspects.cli._;
  };
}
