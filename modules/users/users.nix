{ __findFile, ... }:
{
  # Default user settings
  den.ctx.user.includes = [
    # Automatically create the user on host
    <den/define-user>
    # Sets the default shell to zsh
    (<den/user-shell> "zsh")
    # Inserts specific authorised ssh keys by default in all users
    <lib/ssh/authorizedKeys>
  ];

  den.schema.user =
    { user, lib, ... }:
    {
      config.classes = lib.mkDefault [ "homeManager" ];
    };
}
