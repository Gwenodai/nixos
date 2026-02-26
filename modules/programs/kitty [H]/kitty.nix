# https://mynixos.com/home-manager/options/programs.kitty
{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.kitty = {
    pkgs,
    lib,
    ...
  }: {
    programs.kitty = {
      enable = lib.mkDefault true;

      shellIntegration = {
        enableZshIntegration = lib.mkDefault true;
        enableBashIntegration = lib.mkDefault true;
      };
      enableGitIntegration = lib.mkDefault true;
      font = {
        name = lib.mkDefault "JetBrainsMono Nerd Font Mono";
        package = lib.mkDefault pkgs.nerd-fonts.jetbrains-mono;
        # size = "8";
      };
      settings = {
        background_opacity = lib.mkDefault 0.4;
        background = lib.mkDefault "#000000";
      };
    };

    # Custom aliases
    home.shellAliases = {
      ssh = lib.mkDefault "kitty +kitten ssh";
    };

    xdg = {
      terminal-exec = {
        enable = true;
        settings = {
          default = lib.mkBefore [
            "kitty.desktop"
          ];
        };
      };
      mimeApps = {
        associations.added =
          let
            application = "kitty-open.desktop";

            mimeTypes = [
              "application/x-shellscript"
            ];
          in
          lib.genAttrs mimeTypes (mimetype: application);
      };
    };
  };
}