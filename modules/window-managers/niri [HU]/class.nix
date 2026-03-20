{ den, lib, ... }: {
  den.aspects.niri._.class = den.lib.perUser (
    { host, user }: { class, aspect-chain }: den._.forward {
      each = lib.singleton user;
      fromClass = _: "niri";
      intoClass = _: "homeManager";
      intoPath = _: [ "programs" "niri" ];
      fromAspect = _: lib.head aspect-chain;
      adaptArgs = lib.id;
      guard = { options, ... }@hmArgs: options.programs ? niri;
      adapterModule = { lib, ... }: let
        listOption = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [];
        };
      in {
        freeformType = lib.types.attrsOf lib.types.anything;
        options.settings = {
          spawn-at-startup = listOption;
          window-rules = listOption;
          layer-rules = listOption;
        };
      };
    }
  );
}