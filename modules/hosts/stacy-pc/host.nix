{
  # Host metadata for global use
  # TODO: Port public host metadata to den's quirk/pipe system
  flake.lib.hosts = {
    stacy-pc = {
      ip = "192.168.1.92";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGKvThXtl26G7nOsGPtJC82cGGMFjLtQHYuzlHZM7xi8 root@stacy-pc";
    };
  };

  den.hosts.x86_64-linux.stacy-pc = {
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
    };

    users.stacy = { };
  };
}
