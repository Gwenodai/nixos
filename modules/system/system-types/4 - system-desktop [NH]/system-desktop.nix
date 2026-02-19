# Expansion of system-cli for desktop use
{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli

      graphics
      audio
      fonts
      theme-vimix
    ];
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-cli

      xdg
      files
      browser
      kitty
      vscode
    ];
  };
}