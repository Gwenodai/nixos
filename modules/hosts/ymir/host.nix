{
  # Host metadata for global use
  # TODO: Port public host metadata to den's quirk/pipe system
  flake.lib.hosts = {
    ymir = {
      ip = "192.168.1.64";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILKO3VzqMSHdWwg9QH5qMuYjkDAgfmqzzncq7bBRAXm8 root@ymir";
    };
  };

  den.hosts.x86_64-linux.ymir = {
    hardware = {
      platform = "server";
      cpu = {
        vendor = "amd";
        cores = 12;
      };
      gpu = {
        vendor = "amd";
        advancedPowerManagement = true;
      };
    };

    users.gwen = { };
  };
}
