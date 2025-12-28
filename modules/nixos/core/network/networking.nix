{
  hostname,
  ...
}:

{
  # Hostname defined in main flake
  networking.hostName = hostname; 
  networking.networkmanager.enable = true;
}