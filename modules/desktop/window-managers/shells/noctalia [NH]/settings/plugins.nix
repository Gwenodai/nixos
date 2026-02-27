{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.noctalia = {
    config,
    lib,
    ...
  }: {
    programs.noctalia-shell = {
      settings.plugins.autoUpdate = lib.mkDefault false;
      # plugins = {
      #   sources = [
      #     {
      #       enabled = true;
      #       name = "Official Noctalia Plugins";
      #       url = "https://github.com/noctalia-dev/noctalia-plugins";
      #     }
      #   ];
      #   states = {
      #     screen-recorder = {
      #       enabled = true;
      #       sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
      #     };
      #     timer = {
      #       enabled = true;
      #       sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
      #     };
      #   };
      #   version = 1;
      # };
      # pluginSettings = {
      #   screen-recorder = {
      #     audioCodec = "opus";
      #     audioSource = "default_output";
      #     colorRange = "limited";
      #     directory = "${config.xdg.userDirs.videos}";
      #     frameRate = 60;
      #     quality = "very_high";
      #     showCursor = true;
      #     videoCodec = "h264";
      #     videoSource = "portal";
      #   };
      # };
    };
  };
}