{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    powerManagement.cpuFreqGovernor = "performance";
  };
}