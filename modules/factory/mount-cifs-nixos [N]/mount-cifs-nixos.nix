# Outputs cifs share mounts
{
  # --- FACTORY ASPECT ---
  config.flake.factory.mount-cifs-nixos = {
    host,
    resource,
    destination,
    credentialspath ? null, 
    extraoptions ? [], 
    readonly ? false, 
    UID,
    GID,
  }: {
    ...
  }: {
    fileSystems."${destination}" = {
      device = "//${host}/${resource}";
      fsType = "cifs";
      options = let
        mountoptions = [
          "x-systemd.automount"
          "noauto"
          "nofail"
          "_netdev"
          "soft"
          "iocharset=utf8"
          "x-systemd.idle-timeout=60"
          "x-systemd.device-timeout=5s"
          "x-systemd.mount-timeout=5s"
        ];

        user = [
          "uid=${toString UID}"
          "gid=${toString GID}"
        ];

        perms = if readonly then
          [ "ro" ]
        else
          [ "rw" ];

        credentials = if credentialspath != null then
          [ "credentials=${credentialspath}" ] 
        else
          [];
      in
      mountoptions
      ++ extraoptions
      ++ user
      ++ perms
      ++ credentials;
    };
  };
}