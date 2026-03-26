{ den, lib, ... }: {
  den.aspects.messaging = {
    # All default messenging programs are included when the generic 'messaging' aspect is used
    includes = lib.attrValues den.aspects.messaging._;
  };
}
