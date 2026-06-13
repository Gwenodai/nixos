# This battery takes mount parameters as context
{
  den.batteries.mount-cifs =
    {

      hostAddress,
      resource,
      destination,
      credentialsPath ? null,
      extraOptions ? [ ],
      readOnly ? false,
      UID,
      GID,
      ...
    }:
    {
      nixos.fileSystems."${destination}" = {
        device = "//${hostAddress}/${resource}";
        fsType = "cifs";
        options =
          let
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

            perms = if readOnly then [ "ro" ] else [ "rw" ];

            credentials = if credentialsPath != null then [ "credentials=${credentialsPath}" ] else [ ];
          in
          mountoptions ++ extraOptions ++ user ++ perms ++ credentials;
      };
    };
}
