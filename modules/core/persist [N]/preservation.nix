# Ephemeral state management
# https://nix-community.github.io/preservation/configuration-options.html

# This aspect should be imported into any host that wants ephemeral storage
# Like so: `den.aspects.<host>.includes = [ den.aspects.persist ];`

{ inputs, den, ... }: {
  # Flake inputs
  flake-file.inputs.preservation = {
    url = "github:nix-community/preservation";
  };

  den.aspects.persist = {
    includes = with den.aspects.persist.provides; [
      minimalNix     # Minimal necessary system level preservation configuration
      minimalHome    # Minimal necessary user level preservation configuration
      find-ephemeral # Simple tool to list unpreserved files
    ];

    nixos = { config, lib, ... }: {
      # Import the preservation module
      imports = [ inputs.preservation.nixosModules.preservation ];
      # Enable the preservation module by default
      preservation.enable = lib.mkDefault true;
    };
  };
}