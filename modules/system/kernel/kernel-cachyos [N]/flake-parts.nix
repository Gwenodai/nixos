# CachyOS kernel for NixOS
{
  ...
}: {
  flake-file.inputs = {
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };
}