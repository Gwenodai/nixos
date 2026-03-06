# Enables `nix run .#vm`
{
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    ...
  }: {
    packages.vm = pkgs.writeShellApplication {
      name = "vm";
      text = let
        host = inputs.self.nixosConfigurations.gwen-t1.config;
      in ''
        ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
      '';
    };
  };

  den.aspects.ci-no-boot = {
    description = "Disables booting during CI";
    nixos = {
      boot.loader.grub.enable = false;
      fileSystems."/".device = "/dev/null";
    };
  };
}
