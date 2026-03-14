{ den, ... }: {
  # These are global static settings
  den.default.includes = [
    # ${user}.provides.${host} and ${host}.provides.${user}
    den.provides.mutual-provider
    # Provides flake-parts inputs' (system-specialized inputs) as a module argument
    den.provides.inputs'
    # Provides flake-parts self' (system-specialized self) as a module argument
    den.provides.self'
  ];
}