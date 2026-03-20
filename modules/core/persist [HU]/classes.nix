{ den, lib, ... }: let
  # --- Shared Deduplication Module --- #
  dedupModule = { lib, ... }: {
    freeformType = with lib.types; attrsOf anything;
    options = {
      directories = lib.mkOption {
        type = with lib.types; listOf anything; 
        default = [];
        apply = lib.unique; 
      };
      files = lib.mkOption {
        type = with lib.types; listOf anything;
        default = [];
        apply = lib.unique;
      };
    };
  };

  # ---Class factories--- #
  # Factory to generate system-level custom classes
  mkSystemClass = {
    fromClass, intoPath, dedup ? false, requiresFindEphemeral ? false
  }: den.lib.perHost (
    { class, aspect-chain }: den._.forward ({
      each = lib.singleton true;
      fromClass = _: fromClass;
      intoClass = _: "nixos"; # Preservation only supports NixOS
      intoPath = _: intoPath;
      fromAspect = _: lib.head aspect-chain;
      guard = { config, options, lib, ... }@osArgs: _: let
        hasPreservation = options ? preservation;
        hasFindEphemeral = lib.any (pkg:
        (pkg.name or "") == "find-ephemeral") config.environment.systemPackages;
      in
        lib.mkIf (hasPreservation &&
        (!requiresFindEphemeral || hasFindEphemeral));
      adaptArgs = args: args // { osConfig = args.config; };
    } // lib.optionalAttrs dedup {
      adapterModule = dedupModule;
    })
  );

  # Factory to generate user-level custom classes
  mkUserClass = {
    fromClass, intoSubPath, dedup ? false, requiresFindEphemeral ? false
  }: den.lib.perUser ({ host, user }:
    { class, aspect-chain }: den._.forward ({
      each = lib.singleton user;
      fromClass = _: fromClass;
      intoClass = _: "nixos"; # Preservation only supports NixOS
      intoPath = u: [ "hostConfig" "preservation" intoSubPath u.userName ];
      fromAspect = _: lib.head aspect-chain;
      guard = { config, options, lib, ... }@osArgs: _: let
        hasPreservation = options ? preservation;
        hasHomeManager = lib.elem "homeManager" (user.classes or []);
        hasFindEphemeral = lib.any (pkg:
          (pkg.name or "") == "find-ephemeral") config.environment.systemPackages;
      in
        lib.mkIf (hasPreservation && hasHomeManager &&
        (!requiresFindEphemeral || hasFindEphemeral));
      adaptArgs = { config, ... }@args: args // {
        hmConfig = config.home-manager.users.${user.userName};
      };
    } // lib.optionalAttrs dedup {
      adapterModule = dedupModule;
    })
  );

in {
  den.aspects.persist._.classes = {
    includes = with den.aspects.persist._.classes._; [ sys user ];

    _.sys = {
      includes = [
        (mkSystemClass {
          fromClass = "persist";
          intoPath = [ "preservation" "preserveAt" "/persist" ];
          dedup = true;
        })
        (mkSystemClass {
          fromClass = "persistTmp";
          intoPath = [ "hostConfig" "preservation" "tmpfiles" ];
        })
        (mkSystemClass {
          fromClass = "persistIgnore";
          intoPath = [ "hostConfig" "preservation" "ignore" ];
          dedup = true;
          requiresFindEphemeral = true;
        })
      ];
    };
    
    _.user = {
      includes = [
        (mkUserClass {
          fromClass = "persistUser";
          intoSubPath = "userPersist";
          dedup = true;
        })
        (mkUserClass {
          fromClass = "persistUserTmp";
          intoSubPath = "userTmpfiles";
        })
        (mkUserClass {
          fromClass = "persistUserIgnore";
          intoSubPath = "userIgnore";
          dedup = true;
          requiresFindEphemeral = true;
        })
      ];
    };
  };
}