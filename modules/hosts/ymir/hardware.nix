let
  hostName = "ymir";
  system = "x86_64-linux";
in
{
  den.hosts.${system}.${hostName} = {
    hardware = {
      platform = "server";

      #---Host Specs---#
      cpu = {
        vendor = "amd";
        cores = 12;
      };
      gpu = {
        vendor = "amd";
        advancedPowerManagement = true;
      };
    };
  };
}
