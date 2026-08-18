{
  den.hosts.x86_64-linux.ymir.hostConfig = {
    hardware = {
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
