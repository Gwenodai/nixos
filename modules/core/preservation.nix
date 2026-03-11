# Ephemeral state management
# https://nix-community.github.io/preservation/configuration-options.html
{ inputs, den, lib, ... }: let
  # Create a `persist` class to house preservation config
  persistClass = { class, aspect-chain }: den.provides.forward {
    each = lib.singleton true;
    fromClass = _: "persist";
    intoClass = _: "nixos";
    intoPath = _: [ "preservation" "preserveAt" "/persist" ];
    fromAspect = _: lib.head aspect-chain;
    guard = { options, ... }@osArgs: options ? preservation;
    adaptArgs = args: args // { osConfig = args.config; };
  };
  persistUserClass = { host, user }: { class, aspect-chain }: den.provides.forward {
    each = lib.singleton user;
    fromClass = _: "userPersist";
    intoClass = _: "nixos";
    intoPath = u: [ "preservation" "preserveAt" "/persist" "users" u.userName ];
    fromAspect = _: lib.head aspect-chain;
    guard = { options, ... }@osArgs: options ? preservation;
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
  # Register the `userPersist` class
  den.ctx.user.includes = [ persistUserClass ];

  den.aspects.persist = {
    # Register the `persist` class 
    includes = [ persistClass ];
    
    nixos = {
      # FIXME: Boot config is temp
      boot = {
        initrd = {
          systemd.enable = lib.mkDefault true;
        };

        loader = {
          systemd-boot.enable = lib.mkDefault true;
          efi.canTouchEfiVariables = lib.mkDefault true;
        };
      };
      
      # Import the preservation module
      imports = [ inputs.preservation.nixosModules.preservation ];
      preservation.enable = true; # Enable the module
    };
  };

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
}