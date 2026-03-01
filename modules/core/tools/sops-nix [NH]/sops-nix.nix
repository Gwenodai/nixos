{
  inputs,
  self,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.sops-nix = {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    home-manager.sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];

    environment.systemPackages = with pkgs; [
      age
      sops
      ssh-to-age
    ];

    sops = {
      age.sshKeyPaths = lib.mkDefault [ "/etc/ssh/ssh_host_ed25519_key" ];
      defaultSopsFile = lib.mkDefault (self + "/secrets/common/secrets.yaml");
    };
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.sops-nix = {
    config,
    lib,
    ...
  }: {
    sops = {
      age.keyFile = lib.mkDefault "${config.xdg.configHome}/sops/age/keys.txt";
      defaultSopsFile = lib.mkDefault (self + "/secrets/${config.home.username}/secrets.yaml");
    };
  };
}