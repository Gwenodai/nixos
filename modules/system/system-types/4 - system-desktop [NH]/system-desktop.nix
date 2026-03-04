# Expansion of system-cli for desktop use
{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli

      polkit
      graphics
      audio
      fonts
      theme
    ];
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-cli

      keyring
      polkit
      nemo
      browser
      kitty
      vscode
      spotify
      discord
      messenger
      theme
    ];
  };
}