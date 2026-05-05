{ den, lib, ... }:
let
  # --- Shared Deduplication Module --- #
  # Without this `adapterModule` the `persist`, `persistIgnore`, and user
  # relative classes will duplicate values within their respective lists
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

  # ---Class factories--- #
  # Factory to generate system-level custom classes
  mkHostClass =
    {
      fromClass,
      intoPath,
      dedup ? false,
      requiresFindEphemeral ? false,
    }:
    den.lib.perHost (
      { class, aspect-chain }:
      den._.forward (
        {
          each = lib.singleton true;
          fromClass = _: fromClass;
          intoClass = _: "nixos"; # Preservation only supports NixOS
          intoPath = _: intoPath;
          fromAspect = _: lib.head aspect-chain;
          guard =
            { config, options, ... }@osArgs:
            _:
            let
              hasFindEphemeral = lib.any (
                pkg: (pkg.name or "") == "find-ephemeral"
              ) config.environment.systemPackages;
            in
            lib.mkIf (!requiresFindEphemeral || hasFindEphemeral);
          adaptArgs = args: args // { osConfig = args.config; };
        }
        // lib.optionalAttrs dedup {
          adapterModule = dedupModule;
        }
      )
    );

  # Factory to generate user-level custom classes
  mkUserClass =
    {
      fromClass,
      intoSubPath,
      dedup ? false,
      requiresFindEphemeral ? false,
    }:
    den.lib.perUser (
      { host, user }:
      { class, aspect-chain }:
      den._.forward (
        {
          each = lib.singleton user;
          fromClass = _: fromClass;
          intoClass = _: "nixos"; # Preservation only supports NixOS
          intoPath = u: [
            "hostConfig"
            "preservation"
            intoSubPath
            u.userName
          ];
          fromAspect = _: lib.head aspect-chain;
          guard =
            { config, options, ... }@osArgs:
            _:
            let
              hasHomeManager = lib.elem "homeManager" (user.classes or [ ]);
              hasFindEphemeral = lib.any (
                pkg: (pkg.name or "") == "find-ephemeral"
              ) config.environment.systemPackages;
            in
            lib.mkIf (hasHomeManager && (!requiresFindEphemeral || hasFindEphemeral));
          adaptArgs =
            { config, ... }@args:
            args
            // {
              hmConfig = config.home-manager.users.${user.userName};
            };
        }
        // lib.optionalAttrs dedup {
          adapterModule = dedupModule;
        }
      )
    );

in
{
  den.aspects.persist = {
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
        requiresFindEphemeral = true;
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
        requiresFindEphemeral = true;
      })
    ];
  };
}
