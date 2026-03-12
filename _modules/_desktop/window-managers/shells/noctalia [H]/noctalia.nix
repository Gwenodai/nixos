# Minimal desktop shell Niri/Hyprland
# https://noctalia.dev/
# https://docs.noctalia.dev/getting-started/nixos/#config-ref
{
  inputs,
  ...
}: {
  # Convenience function to set Noctalia settings
  # only if the Noctalia module was imported
  flake.lib = {
    mkIfNoctalia= {
      options,
      ...
    }: input:
      if ( options ? home && options.programs ? noctalia-shell ) then
        input # If the `noctalia-shell` option is present, the input is valid
      else
        { };  # else we replace it with nothing
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.noctalia = {
    config,
    pkgs,
    lib,
    ...
  }: let
    # Small application to easily show changed values from live noctalia settings
    noctalia-diff = pkgs.writeShellApplication {
      name = "noctalia-diff";
      runtimeInputs = [
        pkgs.bat-extras.batdiff # Provides batdiff
        pkgs.jq                 # Provides jq
      ];
      text = lib.replaceStrings ["# syntax: bash\n"] [""] ''
        # syntax: bash
        batdiff <(jq -S . "${config.xdg.configHome}/noctalia/settings.json") <(noctalia-shell ipc call state all | jq -S .settings)
      '';
    };
  in {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia-shell = {
      enable = lib.mkDefault true;
      systemd.enable = lib.mkDefault true; # Run noctalia via systemd instead of manually within niri/hyprland
    };

    home.packages = [ noctalia-diff ];
  };
}
