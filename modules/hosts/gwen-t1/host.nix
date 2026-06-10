let
  hostName = "gwen-t1";
in
{
  # Host metadata for global use
  # TODO: Port public host metadata to den's quirk/pipe system
  flake.lib.hosts = {
    ${hostName} = {
      ip = "192.168.1.37";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJAJ1rnquy24cUcTB0c/B/2sYTsH+TzHRcIYcqRciQIu root@gwen-t1";
    };
  };

  den.hosts.x86_64-linux.${hostName} = {
    users.gwen = { };
    # users.stacy = { };

    hardware = {
      platform = "desktop";

      cpu = {
        vendor = "amd";
        lowLatencyScheduler = true;
        cores = 8;
      };

      gpu = {
        vendor = "amd";
        advancedPowerManagement = true;
      };

      display."Dell Inc. AW3425DW 4ZZD274" = {
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
        focus-at-startup = true;
        variable-refresh-rate = "on-demand";
      };

      touchscreen = "Invalid Vendor Codename - RTK 0x1920 0x19201080";
      display."Invalid Vendor Codename - RTK 0x1920 0x19201080" = {
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

      ### External Display
      display."Philips Consumer Electronics Company PHILIPS FTV 0x01010101" = {
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
  };
}
