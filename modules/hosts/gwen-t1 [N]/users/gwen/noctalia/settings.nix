{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    ...
  }: {
    # --- HOME MANAGER MODULE ---
    home-manager.users.gwen = {
      options,
      config,
      ...
    }: {
      config = inputs.self.lib.mkIfNoctalia { inherit options; } {
        programs.noctalia-shell = {
          settings = {
            general = {
              # lockScreenMonitors = [ "HDMI-A-1" ]; # Only show lockscreen on bottom screen
            };
            colorSchemes = {
              predefinedScheme = "Rosey AMOLED";
            };
            bar = {
              useSeparateOpacity = true; # Allow top bar opacity to be set seperate from regular opacity
              backgroundOpacity  = 1;    # Fully opaque black top bar looks nicer on OLED screen
            };
            wallpaper = {
              wallhavenRatios = "21x9"; # Default size to search for
            };
          };
        };
      };
    };
  };
}
