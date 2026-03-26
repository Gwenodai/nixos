{ den, lib, ... }: {
  den.aspects.messaging._.discord._.vesktop = {
    # Bundles all vesktop components when the complete 'vesktop' sub-aspect is used
    includes = lib.attrValues den.aspects.messaging._.discord._.vesktop._;
  };
}
