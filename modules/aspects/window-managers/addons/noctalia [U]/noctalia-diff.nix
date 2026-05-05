{ den, ... }:
let
  diff = den.lib.perUser {
    homeManager =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      let
        # Small application to easily show changed values from live noctalia settings
        noctalia-diff = pkgs.writeShellApplication {
          name = "noctalia-diff";
          runtimeInputs = [
            pkgs.bat-extras.batdiff
            pkgs.jq
          ];
          text = lib.replaceStrings [ "# syntax: bash\n" ] [ "" ] ''
            # syntax: bash
            batdiff <(jq -S . "${config.xdg.configHome}/noctalia/settings.json") \
            <(noctalia-shell ipc call state all | jq -S .settings)
          '';
        };
      in
      {
        home.packages = [ noctalia-diff ];
      };
  };
in
{
  den.aspects.noctalia.includes = [
    diff
  ];
}
