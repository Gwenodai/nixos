{
  den,
  ...
}: {
  # These are global static settings
  den.default.includes = [
    # ${user}.provides.${host} and ${host}.provides.${user}
    den.provides.mutual-provider
  ];
}