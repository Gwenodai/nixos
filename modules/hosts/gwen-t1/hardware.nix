let
  hostName = "gwen-t1";
  system = "x86_64-linux";
in
{
  den.hosts.${system}.${hostName} = {
    hardware = {
      platform = "desktop";

      #---Host Specs---#
      cpu = {
        vendor = "amd";
        lowLatencyScheduler = true;
        cores = 8;
      };

      gpu = {
        vendor = "amd";
        advancedPowerManagement = true;
      };

      #---Displays---#
      display = {
        "Dell Inc. AW3425DW 4ZZD274" = {
          focus-at-startup = true;
          mode = {
            width = 3440;
            height = 1440;
            refresh = 239.984;
          };
          position = {
            x = 0;
            y = 0;
          };
          scale = 1;
          variable-refresh-rate = "on-demand";
        };
        "Invalid Vendor Codename - RTK 0x1920 0x19201080" = {
          mode = {
            width = 1920;
            height = 1080;
          };
          position = {
            x = 740;
            y = 1440;
          };
          scale = 1;
          transform.rotation = 180;
        };

        ## External Display
        "Philips Consumer Electronics Company PHILIPS FTV 0x01010101" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.000;
          };
          position = {
            x = -1920;
            y = 180;
          };
          scale = 1;
        };
      };

      touchscreen = "Invalid Vendor Codename - RTK 0x1920 0x19201080";
    };
  };
}
