# Audio config
{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.audio = {
    lib,
    ...
  }: {
    services = {
      pulseaudio.enable = lib.mkDefault false;
      pipewire = {
        enable = lib.mkDefault true;
        alsa.enable = lib.mkDefault true;
        alsa.support32Bit = lib.mkDefault true;
        pulse.enable = lib.mkDefault true;
      };
    };

    security.rtkit.enable = lib.mkDefault true;
  };
}