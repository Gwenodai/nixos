{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.xdg = {
    ...
  }: {
    # Ensure portal definitions and DE provided configurations get linked
    environment.pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.xdg = {
    config,
    pkgs,
    lib,
    ...
  }: {
    xdg = {
      enable = lib.mkDefault true;
      mimeApps.enable = lib.mkDefault true;
      autostart.enable = lib.mkDefault true;

      userDirs = let
        docs = config.xdg.userDirs.documents;
      in
      inputs.self.lib.applyDefaults {
        enable = config.xdg.enable;
        createDirectories = false;
        # Directories
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

      portal = {
        enable = lib.mkDefault config.xdg.enable;
        extraPortals = lib.mkDefault [
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
        config = {
          common = {
            default = lib.mkDefault [
              "gnome"
              "gtk"
            ];
          };
        };
      };
    };

    home = {
      preferXdgDirectories = lib.mkDefault config.xdg.enable; # Programs use XDG dirs if supported

      packages = with pkgs; [
        xdg-ninja # Shell script which checks $HOME for unwanted files and directories.
      ];
    };
  };
}