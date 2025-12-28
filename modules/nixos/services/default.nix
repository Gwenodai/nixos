{ ... }:

{
  # All services
  imports = [
      ./audio.nix
      ./xserver.nix
  ];
}