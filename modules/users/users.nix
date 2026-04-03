{ den, __findFile, ... }: {
  # Default user settings
  den.ctx.user.includes = [
    # Automatically create the user on host
    den._.define-user
    # Sets the default shell to zsh
    ( den._.user-shell "zsh" )
    # Inserts specific authorised ssh keys by default in all users
    <lib/ssh/authorizedKeys>
  ];
}