{ den, ... }:
{
  den.schema.host =
    { host, lib, ... }:
    let
      ### Generate a list of all aspects included in the current host
      activeAspectsList = lib.filter (aspect: host.hasAspect aspect) (lib.attrValues den.aspects);
      # Only list the aspect name itself, not the full attribute set
      activeAspectNames = lib.map (aspect: aspect.name) activeAspectsList;

      ### Generate grouped lists of all aspects that contain `meta.category` attributes
      activeWithCategory = lib.filter (aspect: aspect ? meta.category) activeAspectsList;
      groupedByCategory = lib.groupBy (aspect: aspect.meta.category) activeWithCategory;
      categorizedNames = lib.mapAttrs (_: aspects: lib.map (a: a.name) aspects) groupedByCategory;
    in
    {
      options = {
        activeAspects = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          readOnly = true;
          default = activeAspectNames;
          description = "List of active aspects for this host";
        };

        activeAspectsByCategory = lib.mkOption {
          type = lib.types.attrsOf (lib.types.listOf lib.types.str);
          readOnly = true;
          default = categorizedNames;
          description = "List of active aspects for this host grouped by their defined categories";
        };
      };
    };
}
