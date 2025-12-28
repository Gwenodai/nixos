{ ... }:

{
  imports = [
      ./git
      ./neovim
      ./shell
      ./pkgs.nix
  ];

  # Allow installing unfree packages
  nixpkgs.config.allowUnfree = true;
}