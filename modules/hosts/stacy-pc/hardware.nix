{
  den.hosts.x86_64-linux.stacy-pc.hostConfig = {
    hardware = {
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
    };

    #---Displays---#
    display = {
      "ViewSonic Corporation XG2401 SERIES 0x01010101" = {
        focus-at-startup = true;
        mode = {
          width = 1920;
          height = 1080;
          refresh = 143.855;
        };
        position = {
          x = 0;
          y = 0;
        };
        scale = 1;
        variable-refresh-rate = "on-demand";
      };

      "Samsung Electric Company S24D300 0x5A5A4631" = {
        mode = {
          width = 1920;
          height = 1080;
        };
        position = {
          x = 1920;
          y = 0;
        };
        scale = 1;
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
          y = 0;
        };
        scale = 1;
      };
    };
  };
}
