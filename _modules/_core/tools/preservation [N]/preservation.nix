# Import Preservation and create a function to check if the module was imported
{
  inputs,
  ...
}: {
  # Convenience function to set preservation settings
  # only if the Preservation module was imported
  flake.lib = {
    mkIfPreservation = {
      options,
      ...
    }: input:
      let
        nix = options ? preservation;
        home = ( options ? home && options ? host && options.host ? preservation );
      in
      if ( home || nix ) then
        input # If the preservation option is present, the input is valid
      else
        { };  # else we replace it with nothing
  };

  # --- NIXOS MODULE ---
  flake.modules.nixos.preservation = {
    imports = [
      inputs.preservation.nixosModules.preservation
    ];

    # Import the Home Manager module automatically
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.preservation
    ];

    preservation.enable = true;
  };
}