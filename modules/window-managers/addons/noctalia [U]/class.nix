{ den, lib, ... }: {
  den.aspects.noctalia._.class = den.lib.perUser (
    { class, aspect-chain }: den._.forward {
      each = lib.singleton true;
      fromClass = _: "noctalia";
      intoClass = _: "homeManager";
      intoPath = _: [ "programs" "noctalia-shell" ];
      fromAspect = _: lib.head aspect-chain;
      adaptArgs = lib.id;
      guard = { options, ... }@hmArgs: options.programs ? noctalia-shell;
    }
  );
}