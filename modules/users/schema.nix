# This file defines the base schema for all users
{
  den.schema.user =
    { lib, ... }:
    {
      # All users are home-manager users unless otherwise specified
      classes = lib.mkDefault [ "homeManager" ];
    };
}
