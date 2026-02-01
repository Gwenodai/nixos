# Import Preservation and create a function to check if the module was imported
{
  inputs,
  ...
}: {
  # Convenience function to set preservation settings only
  # if Preservation module was imported
  flake.lib = {
    mkIfPreservation = {
      options,
      ...
    }: settings:
      if (options ? home && options.home ? preservation) then
        { home.preservation = settings; }
      else if (options ? preservation) then
        { preservation = settings; }
      else
        { };
  };

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