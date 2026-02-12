{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    pkgs,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          terminal = {
            external.linuxExec = "${pkgs.kitty}/bin/kitty";

            integrated = {
              defaultProfile.linux = "zsh";
              cursorBlinking = true;
              cursorStyle = "line";
              smoothScrolling = true;
            };
          };
        };
      };
    };
  };
}