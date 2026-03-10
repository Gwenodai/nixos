# Ephemeral state management
# https://nix-community.github.io/preservation/configuration-options.html
{
  inputs,
  den,
  lib,
  ...
}: {
  # Flake inputs
  flake-file.inputs.preservation = {
    url = "github:nix-community/preservation";
  };

  den.aspects.persist = let
    # Create a `persist` class to house preservation config
    persistClass = { aspect-chain, ... }: den.provides.forward {
      each = lib.singleton true;
      fromClass = _: "persist";
      intoClass = _: "nixos";
      intoPath = _: [ "preservation" "preserveAt" "/persist" ];
      fromAspect = _: lib.head aspect-chain;
      guard = { options, ... }@osArgs: options ? preservation;
    };
  in {
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
    # Register the `persist` class 
    includes = [ persistClass ];
  };
}