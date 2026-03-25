{ den, ... }: {
  den.aspects.messaging._.discord._.vesktop = {
    # Bundles all vesktop components when the complete 'vesktop' sub-aspect is used
    includes = with den.aspects.messaging._.discord._.vesktop._; [
      enable
      config
    ];
  };
}
