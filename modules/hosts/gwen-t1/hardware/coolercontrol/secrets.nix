{
  den.aspects.gwen-t1 = {
    nixos.sops.secrets.coolercontrol-password = {
      mode = "0600";
      owner = "root";
      group = "root";
      path = "/etc/coolercontrol/.passwd";
    };
  };
}
