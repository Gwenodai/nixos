{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.fonts = {
    pkgs,
    config,
    lib,
    ...
  }: {
    config = lib.mkMerge [
      {
        # Regular fonts
        fonts.packages = with pkgs; [
          fira
          jetbrains-mono
          adwaita-fonts
          googlesans-code
        ];
      }
      {
        # Nerd-fonts
        fonts.packages = with pkgs.nerd-fonts; [
          symbols-only
          fira-mono
          fira-code
          adwaita-mono
          jetbrains-mono
        ];
      }
    ];
  };
}