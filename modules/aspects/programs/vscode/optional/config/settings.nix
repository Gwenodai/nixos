{ inputs, ... }:
{
  den.aspects.vscode.config = {
    nixos =
      { pkgs, ... }:
      {
        # Make sure "JetBrainsMono Nerd Font" is available
        fonts.packages = with pkgs.nerd-fonts; [ jetbrains-mono ];
      };

    homeManager =
      {
        host,
        pkgs,
        lib,
        ...
      }:
      {
        programs.vscode.profiles.default.userSettings = {
          editor = {
            # Single quotes are required for font names with spaces
            fontFamily = lib.concatStringsSep ", " [
              "'JetBrainsMono Nerd Font'"
              "'Droid Sans Mono'"
              "monospace"
            ];
            # Combines multiple characters '!'+'='becomes '≠'
            fontLigatures = true;

            ### Brackets
            guides.bracketPairs = "active";
            bracketPairColorization = {
              enabled = true;
              independentColorPoolPerBracketType = false;
            };

            ### Indentation
            insertSpaces = true;
            indentSize = "tabsize";
            tabSize = 2;

            ### Wrapping
            wordWrap = "on";
            # wordWrapColumn = 80;
            wrapOnEscapedLineFeeds = false;
          };

          explorer = {
            fileNesting = {
              enabled = true;
              expand = true;
            };
            sortOrder = "foldersNestsFiles";
          };

          workbench = {
            editor.decorations.colors = true;
            list.smoothScrolling = true;
            reduceMotion = "off";
          };

          # Make sure we always use our defined colour schemes
          window = {
            autoDetectColorScheme = false;
            autoDetectHighContrast = false;
          };

          editor = {
            cursorSmoothCaretAnimation = "on";
            cursorBlinking = "phase";
            smoothScrolling = true;
            linkedEditing = true;
          };

          search = {
            collapseResults = "auto";
          };

          # Set source control to tree view for easier parsability
          scm.defaultViewMode = "tree";

          diffEditor = {
            renderSideBySide = false;
            experimental = {
              useTrueInlineView = true;
              showMoves = false;
            };
            hideUnchangedRegions.enabled = false;
            ignoreTrimWhitespace = false;
          };

          git.untrackedChanges = "separate";
          github.gitProtocol = "ssh";

          terminal = {
            external.linuxExec = (
              inputs.self.lib.getActiveAspectBinByPrefix {
                inherit
                  host
                  pkgs
                  ;
                prefix = "terminal-";
              }
            );

            integrated = {
              defaultProfile.linux = "zsh";
              cursorBlinking = true;
              cursorStyle = "line";
              smoothScrolling = true;
            };
          };

          workbench = {
            settings.alwaysShowAdvancedSettings = true;
            startupEditor = "none"; # Disable the welcome page
          };

          # Disable vscode/extension updates (This is handled by nix)
          update.mode = "none";
          extensions = {
            autoUpdate = false;
            autoCheckUpdates = false;
          };

          security.workspace.trust.enabled = false;
          # experimentalGpuAcceleration = "on";
        };
      };

    ### Persist config
    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.cache/fontconfig"
          "${hmConfig.xdg.cacheHome}/fontconfig"
        ];
      };
  };
}
