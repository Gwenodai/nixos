{
    hostname,
    ...
}:

{
  # TODO: Split into seperate module
  # --- NETWORKING ---
  networking.hostName = hostname; 
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}