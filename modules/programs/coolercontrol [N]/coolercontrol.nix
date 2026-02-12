# Web accessible via http://localhost:11987/
{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.coolercontrol = {
    pkgs,
    ...
  }: {
    programs.coolercontrol = {
      enable = true;
    };
    
    environment.systemPackages = with pkgs; [
      lm_sensors # Tools for reading hardware sensors
      liquidctl  # Drivers for AIO liquid coolers and other devices
    ];
  };
}