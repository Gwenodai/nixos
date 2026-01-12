{
  flake.modules.nixos.cli-tools = {
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      home-manager
      parted
    ];
  };
}