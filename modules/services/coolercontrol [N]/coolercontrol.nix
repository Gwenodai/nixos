# Web accessible via http://localhost:11987/
{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.coolercontrol = {
    pkgs,
    lib,
    ...
  }: {
    # Create an option to store id's for use in CoolerControl configs
    options = {
      programs.coolercontrol.id = lib.mkOption {
        type = with lib.types; attrsOf attrs;
        default = {};
        description = "ID list for CoolerControl";
      };
    };

    config = {
      programs.coolercontrol = {
        enable = true;
      };
        
      environment.systemPackages = with pkgs; [
        lm_sensors # Tools for reading hardware sensors
        liquidctl  # Drivers for AIO liquid coolers and other devices
      ];
    };
  };
}