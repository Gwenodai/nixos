{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.messenger = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [ pkgs.caprine ];

    # Autostart
    xdg.configFile."autostart/caprine.desktop".text = ''
      [Desktop Entry]
      NotShowIn=niri
      Categories=Network;InstantMessaging;Chat
      Comment=Elegant Facebook Messenger desktop app
      Exec=${pkgs.caprine}/bin/caprine
      Icon=caprine
      MimeType=x-scheme-handler/caprine
      Name=Caprine
      Terminal=false
      Type=Application
      Version=1.5
    '';
  };
}