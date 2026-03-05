# Host secrets config
{
  self,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    ...
  }: {
    # Set the default file and format for this specific host
    sops.defaultSopsFile = self + "/secrets/gwen/secrets.yaml";
  };
}
