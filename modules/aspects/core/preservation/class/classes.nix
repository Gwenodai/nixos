{ den, lib, ... }:
let
  ### Shared Deduplication Module
  # Without this `adapterModule` the `persist`, `persistIgnore`, and user relative
  # classes allow for duplicate values to appear within their respective lists
  dedupModule = {
    options = {
      directories = lib.mkOption {
        type = with lib.types; listOf anything;
        default = [ ];
        apply = lib.unique;
      };
      files = lib.mkOption {
        type = with lib.types; listOf anything;
        default = [ ];
        apply = lib.unique;
      };
    };
  };

  ### Class factories
  # Factory to generate host-level custom classes
  mkHostClass =
    {
      fromClass,
      intoPath,
      dedup ? false,
    }:
    { class, aspect-chain }:
    den.batteries.forward (
      {
        each = lib.singleton true;
        fromClass = _: fromClass;
        intoClass = _: "nixos";
        intoPath = _: intoPath;
        fromAspect = _: lib.head aspect-chain;
        adaptArgs = args@{ config, ... }: args // { osConfig = config; };
      }
      // lib.optionalAttrs dedup {
        adapterModule = dedupModule;
      }
    );

  # Factory to generate user-level custom classes
  mkUserClass =
    {
      fromClass,
      intoSubPath,
      dedup ? false,
    }:
    { user }:
    den.batteries.forward (
      {
        each = lib.singleton user;
        fromClass = _: fromClass;
        intoClass = _: "nixos";
        intoPath = u: [
          "hostConfig"
          "preservation"
          intoSubPath
          u.userName
        ];
        fromAspect = user: den.aspects.${user.aspect};
        adaptArgs =
          args@{ config, ... }:
          args
          // {
            hmConfig = config.home-manager.users.${user.userName};
          };
      }
      // lib.optionalAttrs dedup {
        adapterModule = dedupModule;
      }
    );

in
{
  den.aspects.preservation = {
    includes = [
      (mkHostClass {
        fromClass = "persist";
        intoPath = [
          "preservation"
          "preserveAt"
          "/persist"
        ];
        dedup = true;
      })

      (mkHostClass {
        fromClass = "persistTmp";
        intoPath = [
          "hostConfig"
          "preservation"
          "tmpfiles"
        ];
      })

      (mkHostClass {
        fromClass = "persistIgnore";
        intoPath = [
          "hostConfig"
          "preservation"
          "ignore"
        ];
        dedup = true;
      })

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
      })
    ];
  };
}
