{
  flake.modules.nixos.cli-tools = {
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      home-manager # Manage a user environment using Nix
      parted # CLI program for creating and manipulating partition tables
    ];
  };
}