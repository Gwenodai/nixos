{
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
      in {
        enable = lib.mkDefault true;
        createDirectories = lib.mkDefault false;

        documents   = lib.mkDefault "${config.home.homeDirectory}/Documents";
        desktop     = lib.mkDefault "${docs}/Desktop";
        download    = lib.mkDefault "${docs}/Downloads";
        pictures    = lib.mkDefault "${docs}/Pictures";
        videos      = lib.mkDefault "${docs}/Videos";
        music       = lib.mkDefault "${docs}/Music";
        templates   = lib.mkDefault "${docs}/Templates";
        publicShare = lib.mkDefault null;
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