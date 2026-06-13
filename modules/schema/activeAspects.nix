{ den, ... }:
let
  mkAspectSchema =
    {
      entity,
      typeName,
      lib,
    }:
    let
      ### Generate a list of all aspects included in the current entity
      activeAspectsList = lib.filter (aspect: entity.hasAspect aspect) (lib.attrValues den.aspects);
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
          description = "List of active aspects for this ${typeName}";
        };

        activeAspectsByCategory = lib.mkOption {
          type = lib.types.attrsOf (lib.types.listOf lib.types.str);
          readOnly = true;
          default = categorizedNames;
          description = "List of active aspects for this ${typeName} grouped by their defined categories";
        };
      };
    };
in
{
  den.schema = {
    host =
      { host, lib, ... }:
      mkAspectSchema {
        inherit lib;
        entity = host;
        typeName = "host";
      };
    user =
      { user, lib, ... }:
      mkAspectSchema {
        inherit lib;
        entity = user;
        typeName = "user";
      };
  };
}
