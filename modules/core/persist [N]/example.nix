# Everything here is temporary persist testing aspects
{ lib, ... }: {
  den.aspects.persistExamples = {
    homeManager.xdg.enable = lib.mkDefault true;
    
    persist = {
      directories = [
        { directory = "/var/lib/nixos"; inInitrd = true; }
      ];
      files = [
        {
          file = "/etc/machine-id";
          how = "symlink";
          inInitrd = true;
          configureParent = true;
        }
      ];
    };

    persistUser = { hmConfig, ... }: {
      directories = [
        { directory = "userdir/foo"; mode = "0600"; }
      ];
      files = [
        "userfile/bar.file"
        "${hmConfig.xdg.configHome}/sops"
      ];
    };

    persistTmp = {
      "/foo/bar/dir" = { };
    };

    persistUserTmp = { hmConfig, ... }: {
      "${hmConfig.xdg.configHome}/foo/bar" = { mode = "0700"; };
      "${hmConfig.xdg.configHome}/foo" = { mode = "0700"; };
      "${hmConfig.xdg.configHome}" = { };
      
      "Documents/PersistTest" = { mode = "0700"; }; 
    };

    persistIgnore = {
      directories = [
        "/sys/dir"
      ];
      files = [
        "/sys/file.ext"
      ];
    };
    persistUserIgnore = { hmConfig, ... }: {
      directories = [
        "user/dir"
      ];
      files = [
        "${hmConfig.xdg.configHome}/file.ext"
      ];
    };
  };
}