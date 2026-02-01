{
  inputs,
  ...
}: {
  flake.modules.homeManager.gwen = {
    config,
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      preserveAt."/persist" = {
        commonMountOptions = [
          # Prevent Preservation mounts from appearing as such in graphical file managers
          "x-gvfs-hide"
        ];
      };
    };
  };
}