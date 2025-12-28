{ ... }:

{
  system.stateVersion = "25.05";
  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}