{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.homeManager.xdg = {
    config,
    pkgs,
    lib,
    ...
  }: {
    xdg = {
      enable = lib.mkDefault true;
      mimeApps.enable = lib.mkDefault true;

      userDirs = let
        docs = config.xdg.userDirs.documents;
      in inputs.self.lib.applyDefaults {
        enable = true;
        createDirectories = false;

        documents   = "${config.home.homeDirectory}/Documents";
        desktop     = "${docs}/Desktop";
        download    = "${docs}/Downloads";
        pictures    = "${docs}/Pictures";
        videos      = "${docs}/Videos";
        music       = "${docs}/Music";
        templates   = "${docs}/Templates";
        publicShare = null;
      };

      dataFile."mimeapps.list" = lib.mkDefault {
        source = "${config.xdg.configFile."mimeapps.list".source}";
        force = true;
      };
    };

    home.packages = with pkgs; [
      xdg-ninja # Shell script which checks $HOME for unwanted files and directories.
    ];
  };
}