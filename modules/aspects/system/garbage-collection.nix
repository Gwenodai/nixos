{ inputs, ... }: {
  den.aspects.garbage-collection = {
    nixos = { host, lib, ... }: {
      nix = {
        gc = {
          # Enable automatic garbage collection unless nh is included in the host
          # NH has finer control over garbage collection
          automatic = !lib.elem "nh" host.activeAspects;
          dates = "weekly";
          options = "--delete-older-than 30d";
        };
        settings = {
          auto-optimise-store = true;
          keep-derivations = true;
          keep-outputs = true;
        };
      };
    };
  };
}
