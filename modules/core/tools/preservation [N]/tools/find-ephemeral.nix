# A simple tool to list all files not preserved via preservation in any given directory
{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.preservation = {
    pkgs,
    lib,
    config,
    ...
  }: let
    # --- Helpers ---
    # Extract list of paths from a config set that contains { directories = []; files = []; }
    getPathsFromSet = attrs: let
      rawList = (attrs.directories or []) ++ (attrs.files or []);
      resolve = x: # resolve the actual path string from the object or raw string
        if lib.isString x then
          x
        else
          x.directory or x.file;
    in map resolve rawList; # Run the raw list through the resolve function
    
    # Extract all relevant paths (storage, targets, ignores) from a specific config object
    # 'cfg': The nixos or home-manager user config
    # 'root': The base path to prepend if paths are relative (e.g. /home/user)
    collectPathsFromConfig = cfg: root: let
      # Store the storage locations (keys of preserveAt)
      storage = lib.attrNames (cfg.preservation.preserveAt or {});
      # Store the preservation argets (paths inside preserveAt)
      targets = lib.concatMap 
        (wrapper: getPathsFromSet wrapper) 
        (lib.attrValues (cfg.preservation.preserveAt or {}));
      # Store the explicit ignored paths
      ignores = getPathsFromSet (cfg.preservation.ignore or {});
      # Combine and resolve absolute paths
      allRaw = storage ++ targets ++ ignores;
    in
    map ( # Return all raw paths as absolute paths
      path: # ◁──────────────────────────╮
        if lib.hasPrefix "/" path then # │
          path                         # │
        else                           # │
        "${root}/${path}"              # │
    ) allRaw; # ─────────────────────────╯

    # --- Path Collection ---
    sysPaths = collectPathsFromConfig config "/"; # System Paths (Root is /)
    hmPaths = lib.concatMap                       # Home Manager Paths (Root is user home)
/*╭─▷*/(userCfg: collectPathsFromConfig userCfg userCfg.home.homeDirectory) 
/*╰──*/(lib.attrValues config.home-manager.users);
    # Combined list of all paths to ignore
    allIgnorePaths = lib.lists.unique (sysPaths ++ hmPaths); # Filter out duplicate entries
    # Sanitise inputs before passing them onto bash
    # Result: -path '/excluded/path' -prune -o ...
    ignoreArgs = lib.strings.concatMapStrings (
      p: "-path ${lib.strings.escapeShellArg p} -prune -o "
    ) allIgnorePaths; # -> p ────────────────╯

    # --- Application Construction ---
    find-ephemeral = pkgs.writeShellApplication {
      name = "find-ephemeral";
      runtimeInputs = [
        pkgs.findutils # Provides find
        pkgs.tree      # Provides tree
      ];
      text = ''
        # syntax: bash
        
        show_tree=0
        input_dir="$HOME"

        while [[ $# -gt 0 ]]; do
          case $1 in
            -t|--tree)
              show_tree=1
              shift
              ;;
            *)
              input_dir="$1"
              shift
              ;;
          esac
        done

        # Resolve input_dir to absolute path to ensure matching works
        abs_dir="$(realpath "$input_dir")"

        run_search() {
          find "$abs_dir" \
            -xdev \
            ${ignoreArgs} \
            -type f -printf "%p\n"
        }

        if [ "$show_tree" -eq 1 ]; then
          run_search | tree -a --fromfile
        else
          run_search
        fi
      '';
    };
  in {
    environment.systemPackages = [ find-ephemeral ];
  };
}