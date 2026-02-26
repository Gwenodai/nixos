{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    pkgs,
    lib,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          terminal = inputs.self.lib.applyDefaultsToData {
            external.linuxExec = "${(lib.getExe pkgs.kitty)}";

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