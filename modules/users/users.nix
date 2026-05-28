{ den, ... }:
{
  # Default user settings
  den.schema.user =
    { user, lib, ... }:
    {
      classes = lib.mkDefault [ "homeManager" ];
      includes = [
        # Inserts specific authorised ssh keys by default in all users
        den.aspects.lib.ssh.authorizedKeys
      ];
    };

  den.default.includes = [
    den.batteries.define-user # Automatically create the user on host
    (den.batteries.user-shell "zsh") # Sets the default shell to zsh
  ];
}
