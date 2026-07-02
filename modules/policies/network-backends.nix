{
  den,
  ...
}:
{
  den.quirks.network-backends = {
    description = "Provides network backend information for each host";
  };

  den.policies.network-backends-policy =
    { host, ... }:
    let
      inherit (den.lib.policy) pipe;
    in
    [
      (pipe.from "network-backends" [
        (pipe.collect ({ host, ... }: true))
        pipe.withProvenance
      ])
    ];

  den.schema.host.includes = [ den.policies.network-backends-policy ];
}
