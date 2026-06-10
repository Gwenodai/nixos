{ den, ... }:
{
  ### DEBUG FLAG ####
  flake.den = den;

  systems = [
    "x86_64-linux"
    # "aarch64-linux"
  ];

  ### Global
  den.default.includes = with den.batteries; [
    inputs'
    self'
    hostname
    define-user
    (user-shell "zsh")
  ];

  ### Users
  den.schema.user.includes = with den.aspects; [
    # Inserts specific authorised ssh keys by default in all users
    ssh.authorizedKeys
  ];
}
