# Defines all hosts + users + homes
{
  den,
  lib,
  ...
}:{
  # Gwen PC
  den.hosts.x86_64-linux.gwen-t1.users = {
    gwen.classes = [ "homeManager" ];
  };
  # Server
  den.hosts.x86_64-linux.ymir.users = {
    gwen = {};
  };
  # Stacy PC
  den.hosts.x86_64-linux.stacy-pc.users = {
    stacy.classes = [ "homeManager" ];
  };

  # Default host settings
  den.ctx.host = {
    includes = [
      # Automatically set hostname based on host
      den.provides.hostname
      # Automatically create the user on host
      den.provides.define-user
    ];

    nixos = {
      nix.settings = {    
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        trusted-users = [
          "@wheel"
        ];
      };

      system.stateVersion = "25.11";
      nixpkgs.config.allowUnfree = true;

      security.sudo.extraConfig = ''
        Defaults lecture = "never"
      '';

      # Temp stubs
      boot.loader.grub.enable = false;
      fileSystems."/".device = lib.mkDefault "/dev/fake";
    };
  };
}