{
  inputs,
  self,
  ...
}: {
  flake.lib = {
    commonSopsFile = (self + "/secrets/common/secrets.yaml");
  };

  # --- NIXOS MODULE ---
  flake.modules.nixos.secrets = {
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
      defaultSopsFile = lib.mkDefault inputs.self.lib.commonSopsFile;
    };
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.secrets = {
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