# Ephemeral state management
# https://nix-community.github.io/preservation/configuration-options.html
{ inputs, den, lib, ... }: let
  # System level `persist` class declare preservation config
  persistClass = { class, aspect-chain }: den.provides.forward {
    each = lib.singleton true;
    fromClass = _: "persist";
    intoClass = _: "nixos"; # Preservation only supports NixOS
    intoPath = _: [ "preservation" "preserveAt" "/persist" ];
    fromAspect = _: lib.head aspect-chain;
    guard = { options, ... }@osArgs: options ? preservation;
    adaptArgs = args: args // { osConfig = args.config; };
  };
  # User level `persist` class declare preservation config within home-manager
  persistUserClass = { host, user }: { class, aspect-chain }: den.provides.forward {
    each = lib.singleton user;
    fromClass = _: "userPersist";
    intoClass = _: "nixos"; # Preservation only supports NixOS
    intoPath = u: [ "my" "preservation" "userPersist" u.userName ];
    fromAspect = _: lib.head aspect-chain;
    guard = { options, ... }@osArgs: options ? preservation;
    # Allows access to the home-manager user config within the class
    # via `userPersist = { hmConfig, ... }: {...};`
    adaptArgs = { config, ... }@args: args // {
      hmConfig = config.home-manager.users.${user.userName};
    };
  };
in {
  # Flake inputs
  flake-file.inputs.preservation = {
    url = "github:nix-community/preservation";
  };

  # TODO: Move to `den.ctx.hm-user.includes` after `hm-user` is fixed upstream
  den.ctx.user.includes = [ persistUserClass ]; # Register the `userPersist` class

  den.aspects.persist = {
    includes = [ persistClass ]; # Register the `persist` class  
    nixos = { config, lib, ... }: {
      # Import the preservation module
      imports = [ inputs.preservation.nixosModules.preservation ];

      options.my.preservation.userPersist = lib.mkOption {
        type = lib.types.attrsOf (lib.types.attrsOf lib.types.anything);
        default = {};
        description = "Intermediate holding ground for userPersist configurations.";
      };
      config = {
        preservation.enable = true; # Enable the module

        # Intercept and transform the output of `userPersist` before it reaches `preservation`
        preservation.preserveAt."/persist".users = lib.mapAttrs (userName: rawConfig:
          let # `homePrefix` evaluates to "/home/<user>/" (usually)
            homePrefix = "${config.home-manager.users.${userName}.home.homeDirectory}/";
            # Removes `homePrefix` from the start of strings which contain it
            strip = input:
              if builtins.isString input then     # If input is a string
                lib.removePrefix homePrefix input # Strip the prefix
              else
                input;                            # Otherwise return as-is
            # Recursively walks through `rawConfig` processing values appropriately
            transform = val:
              if builtins.isList val then # `directories = [...]`
                map transform val         # Feed the contents of the list back to `transform`
              else if builtins.isAttrs val then # `{ directory = "..."; mode = "..."; }`
                lib.mapAttrs (key: value: 
                  if key == "directory" || key == "file" then # `directory = "..."`
                    strip value     # Use `strip` to sanitise value for the preservation module
                  else
                    transform value # Feed it through `transform` again
                ) val
              else         # Catch-all for simple string paths in lists ("foo/bar.sh")
                strip val; # Use `strip` to sanitise value for the preservation module
          in
            transform rawConfig # `rawConfig` = `{ directories = [...]; files = [...]; }`
        ) config.my.preservation.userPersist; # Intermediate `userPersist` config location
      };
    };
  };

  # All aspects below are temporary persist testing aspects
  den.aspects.foo = {
    homeManager = { config, ... }: {
      xdg = {
        enable = lib.mkDefault true;
        userDirs = let
          docs = config.xdg.userDirs.documents;
        in {
          enable = config.xdg.enable;
          createDirectories = false;
          # Directories
          documents   = "${config.home.homeDirectory}/Documents";
          desktop     = "${docs}/Desktop";
          download    = "${docs}/Downloads";
          pictures    = "${docs}/Pictures";
          videos      = "${docs}/Videos";
          music       = "${docs}/Music";
          templates   = "${docs}/Templates";
          publicShare = null;
        };
      };
    };

    persist = {
      directories = [
        { directory = "/var/lib/nixos"; inInitrd = true; }
      ];
      files = [
        {
          file = "/etc/machine-id";
          how = "symlink";
          inInitrd = true;
          configureParent = true;
        }
      ];
    };

    userPersist = { hmConfig, ... }: {
      directories = [
        { directory = "userdir/foo"; mode = "0600"; }
      ];
      files = [
        "userfile/bar.file"
        "${hmConfig.xdg.configHome}/sops"
      ];
    };
  };
  den.aspects.gwen-t1.includes = [ den.aspects.persist ];
  den.aspects.gwen.includes = [ den.aspects.foo ];
}