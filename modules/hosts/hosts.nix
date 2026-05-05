# This file defines all hosts and their users
{ den, ... }:
{
  # Host metadata for later reference
  flake.lib.hosts = {
    gwen-t1 = {
      ip = "192.168.1.37";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJAJ1rnquy24cUcTB0c/B/2sYTsH+TzHRcIYcqRciQIu root@gwen-t1";
    };
    stacy-pc = {
      ip = "192.168.1.92";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGKvThXtl26G7nOsGPtJC82cGGMFjLtQHYuzlHZM7xi8 root@stacy-pc";
    };
    ymir = {
      ip = "192.168.1.64";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILKO3VzqMSHdWwg9QH5qMuYjkDAgfmqzzncq7bBRAXm8 root@ymir";
    };
  };

  # Gwen PC
  den.hosts.x86_64-linux.gwen-t1.users = {
    gwen = { };
    # stacy = { };
  };
  # Stacy PC
  den.hosts.x86_64-linux.stacy-pc.users = {
    stacy = { };
  };
  # Server
  den.hosts.x86_64-linux.ymir.users = {
    gwen = { };
  };

  # Default host settings
  den.ctx.host.includes = [
    den._.hostname # Automatically set hostname based on host
  ];
}
