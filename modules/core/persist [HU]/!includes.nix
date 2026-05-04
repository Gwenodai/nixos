{ den, lib, ... }:
{
  den.aspects.persist = {
    # All sub-aspects are included when the generic 'persist' aspect is used
    # enable         - Import and enable the preservation module
    # class          - Custom classes for declaring preservation configs
    # minimal        - Minimal necessary system level preservation configuration
    # find-ephemeral - Simple tool to list unpreserved files
    includes = lib.attrValues den.aspects.persist._;
  };
}
