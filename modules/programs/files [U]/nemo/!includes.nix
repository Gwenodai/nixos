{ den, lib, ... }:
{
  den.aspects.files = {
    # Bundles all nemo components when the complete 'nemo' sub-aspect is used
    includes = lib.attrValues den.aspects.files._.nemo._;
  };
}
