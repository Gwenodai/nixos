{
  den.aspects.gwen-t1 = {
    niri.settings = {
      ### Monitors
      outputs."Dell Inc. AW3425DW 4ZZD274" = {
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

      outputs."Invalid Vendor Codename - RTK 0x1920 0x19201080" = {
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

      input.touch.map-to-output = "Invalid Vendor Codename - RTK 0x1920 0x19201080";

      ### External Displays
      outputs."Philips Consumer Electronics Company PHILIPS FTV 0x01010101" = {
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
