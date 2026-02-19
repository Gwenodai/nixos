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
      # If the preservation option is present, the input is valid,
      # else we replace it with nothing
      if (options ? preservation || (options ? home && options.host ? preservation)) then
        input
      else
        { };
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