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

  # --- NIXOS MODULE ---
  flake.modules.nixos.noctalia = {
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
    ];
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.noctalia = {
    lib,
    ...
  }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      enable = lib.mkDefault true;
      systemd.enable = lib.mkDefault true;
      settings.settingsVersion = lib.mkDefault 53;
      # settings = builtins.readFile ./_settings.json;
    };

    home.shellAliases = {
      noctalia-diff = ''
        nix shell nixpkgs#jq nixpkgs#colordiff -c bash -c "colordiff -u --nobanner <(jq -S . ~/.config/noctalia/settings.json) <(noctalia-shell ipc call state all | jq -S .settings)"
      '';
    };
  };
}
