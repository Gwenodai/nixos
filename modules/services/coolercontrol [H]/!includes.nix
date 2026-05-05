{ den, lib, ... }:
{
  den.aspects.coolercontrol = {
    # All sub-aspects are included when the generic 'coolercontrol' aspect is used
    includes = lib.attrValues den.aspects.coolercontrol._;
  };
}
