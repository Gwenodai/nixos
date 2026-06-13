{
  den.aspects.gwen-t1 = {
    nixos = { lib, ... }: {
      sops.secrets.coolercontrol-password = {
        mode = "0600";
        owner = "root";
        group = "root";
        path = "/etc/coolercontrol/.passwd";
      };

      environment.etc = {
        "coolercontrol/config.toml".text = lib.readFile ./_config.toml;
        "coolercontrol/alerts.json".text = lib.readFile ./_alerts.json;
        "coolercontrol/config-ui.json".text = lib.readFile ./_config-ui.json;
      };
    };
  };
}
