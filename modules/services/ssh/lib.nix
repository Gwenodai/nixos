{
  den.aspects.lib._.ssh = {
    # These SSH keys are authorised for remote access of all of my hosts users.
    # Can be disabled by redeclaring the entry on the user with `lib.mkForce`
    _.authorizedKeys =
      { host, user, ... }:
      {
        nixos.users.users.${user.userName} = {
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILmAgY1ugFGFSF8b47UM4ilNTT13V7SCbYo/VA9EyVq8 gwen@gwen-t1"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMEscSg7Yo3cXMbfYQ6WcQi2XR5zFggK/pFLtsgpHT7L gwen@gwen-s23plus"
          ];
        };

        persistIgnore.directories = [ "/etc/ssh/authorized_keys.d" ];
      };
  };
}
