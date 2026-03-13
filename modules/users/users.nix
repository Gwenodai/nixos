{ den, lib, ... }: {
  # Default user settings
  den.ctx.user.includes = [
    # Users configure their hosts and hosts configure their users
    den.provides.bidirectional
    # Automatically create the user on host
    den.provides.define-user
    # Sets the default shell to zsh
    ( den.provides.user-shell lib.mkDefault "zsh" )
  ];
}