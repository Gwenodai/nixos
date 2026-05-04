{ den, lib, ... }:
{
  den.aspects.cli._.tools = {
    # Bundles all tools components when the complete 'tools' sub-aspect is used
    includes = lib.attrValues den.aspects.cli._.tools._;
  };
}
