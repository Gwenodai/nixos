{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          terminal = {
            external = {
              linuxExec = "kitty";
            };

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