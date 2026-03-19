{ den, lib, ... }: {
  den.aspects.niri._.class = { class, aspect-chain }: den._.forward {
    each = lib.singleton true;
    fromClass = _: "niri";
    intoClass = _: "homeManager";
    intoPath = _: [ "programs" "niri" ];
    fromAspect = _: lib.head aspect-chain;
    adaptArgs = lib.id;
    guard = { options, ... }@hmArgs: options.programs ? niri;
  };
}