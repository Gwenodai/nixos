{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.ssh = {
    lib,
    ...
  }: {
    services.openssh = {
      enable = lib.mkDefault true;
      openFirewall = lib.mkDefault true;
      settings = {
        PermitRootLogin = lib.mkDefault "no";
        PasswordAuthentication = lib.mkDefault true;
      };
    };
  };
}