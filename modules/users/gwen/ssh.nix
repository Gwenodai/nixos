{ den, ... }: {
  den.aspects.gwen = {
    includes = with den.aspects.gwen._; [ ssh-keys ];

    _.ssh-keys = {
      user = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMEscSg7Yo3cXMbfYQ6WcQi2XR5zFggK/pFLtsgpHT7L gwen@gwen-s23plus"
        ];
      };
    };
  };
}
