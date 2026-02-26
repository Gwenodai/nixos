# Minimal desktop shell Niri/Hyprland
# https://noctalia.dev/
{
  inputs,
  ...
}: {
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
    ...
  }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    home.shellAliases = {
      noctalia-diff = ''
        nix shell nixpkgs#jq nixpkgs#colordiff -c bash -c "colordiff -u --nobanner <(jq -S . ~/.config/noctalia/settings.json) <(noctalia-shell ipc call state all | jq -S .settings)"
      '';
    };
  };
}
