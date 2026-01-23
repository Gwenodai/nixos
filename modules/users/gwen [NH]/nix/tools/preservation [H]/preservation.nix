{
  flake.modules.homeManager.gwen = {
    lib,
    config,
    ...
  }: {
    config = lib.mkIf config.preservation.enable {
      home.preservation = {
        preserveAt."/persist" = {
          commonMountOptions = [
            # Prevent Preservation mounts from appearing as such in graphical file managers
            "x-gvfs-hide"
          ];
        };
      };
    };
  };
}