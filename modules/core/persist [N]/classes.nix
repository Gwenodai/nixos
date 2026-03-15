{ den, lib, ... }: let
  # ---Class factories--- #
  # Factory to generate system-level custom classes
  mkSystemClass = { fromClass, intoPath }:
    { class, aspect-chain }: den._.forward {
      each = lib.singleton true;
      fromClass = _: fromClass;
      intoClass = _: "nixos"; # Preservation only supports NixOS
      intoPath = _: intoPath;
      fromAspect = _: lib.head aspect-chain;
      guard = { options, ... }@osArgs: options ? preservation;
      adaptArgs = args: args // { osConfig = args.config; };
    };

  # Factory to generate user-level custom classes
  mkUserClass = { fromClass, intoSubPath }:
    { host, user }: { class, aspect-chain }: den._.forward {
      each = lib.singleton user;
      fromClass = _: fromClass;
      intoClass = _: "nixos"; # Preservation only supports NixOS
      intoPath = u: [ "hostConfig" "preservation" intoSubPath u.userName ];
      fromAspect = _: lib.head aspect-chain;
      guard = { options, ... }@osArgs: # Filter to only home-manager users
        (options ? preservation) &&
        (lib.elem "homeManager" (user.classes or []));
      adaptArgs = { config, ... }@args: args // {
        hmConfig = config.home-manager.users.${user.userName};
      };
    };

  # ---Class definitions--- #
  # System level `persist` class for declaring preservation config
  persistClass = mkSystemClass {
    fromClass = "persist";
    intoPath = [ "preservation" "preserveAt" "/persist" ];
  };
  # User level `persist` class for declaring preservation config
  persistUserClass = mkUserClass {
    fromClass = "persistUser";
    intoSubPath = "userPersist";
  };
  # System level `tmpfiles` class for declaring `systemd.tmpfiles` cleanly
  persistTmpClass = mkSystemClass {
    fromClass = "persistTmp";
    intoPath = [ "hostConfig" "preservation" "tmpfiles" ];
  };
  # User level `tmpfiles` class for declaring `systemd.tmpfiles` cleanly
  persistUserTmpClass = mkUserClass {
    fromClass = "persistUserTmp";
    intoSubPath = "userTmpfiles";
  };
  # System level `ignore` class for declaring files for `find-ephemeral` to ignore
  persistIgnoreClass = mkSystemClass {
    fromClass = "persistIgnore";
    intoPath = [ "hostConfig" "preservation" "ignore" ];
  };
  # User level `ignore` class for declaring files for `find-ephemeral` to ignore
  persistUserIgnoreClass = mkUserClass {
    fromClass = "persistUserIgnore";
    intoSubPath = "userIgnore";
  };

in {
  den.aspects.persist._.classes = {
    includes = with den.aspects.persist._; [
      transformers
      classes._.nixos
      classes._.home
    ];
    # Register the persist classes
    _.nixos = den.lib.take.exactly ({ host }: {
      includes = [
        persistClass
        persistTmpClass
        persistIgnoreClass
      ];
    });
    _.home = {
      includes = [
        persistUserClass
        persistUserTmpClass
        persistUserIgnoreClass
      ];
    };
  };
}