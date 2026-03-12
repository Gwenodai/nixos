{ den, lib, ... }: {
  # Default user settings
  den.ctx.user.includes = [
    # Automatically create the user on host
    den.provides.define-user
    # Sets the default shell to zsh
    ( den.provides.user-shell lib.mkDefault "zsh" )
  ];
}