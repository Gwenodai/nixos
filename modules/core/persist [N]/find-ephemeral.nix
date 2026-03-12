# A simple tool to list all files not preserved via preservation in any given directory
{
  den.aspects.persist.provides.find-ephemeral = {
    nixos = { pkgs, lib, config, ... }: let
      # ---Path collection--- #
      # Filters out intermediate paths injected by the preservation module
      getRealPaths = key: list: 
        let
          # Keep only items where 'how' is NOT "_intermediate"
          validItems = lib.filter (item: (item.how or "") != "_intermediate") list;
        in
          # Extract the string path from the remaining valid attribute sets
          lib.catAttrs key validItems;

      # Storage locations (e.g., "/persist")
      storageLocations = lib.attrNames (config.preservation.preserveAt or {});

      # All persist targets (System + Users)
      targets = lib.concatLists (lib.mapAttrsToList (storageLocations: persistConfig: 
        let
          # Pluck the "directory" and "file" strings out of the attribute sets
          sysDirs  = getRealPaths "directory" (persistConfig.directories or []);
          sysFiles = getRealPaths "file"      (persistConfig.files or []);
          
          # Do the same for user paths
          userPaths = lib.concatLists (lib.mapAttrsToList (uname: ucfg: 
            (getRealPaths "directory" (ucfg.directories or [])) ++
            (getRealPaths "file"      (ucfg.files or []))
          ) (persistConfig.users or {}));
        in
          sysDirs ++ sysFiles ++ userPaths
      ) (config.preservation.preserveAt or {}));

      # All ignored paths
      ignores = (config.my.preservation.ignore.directories or []) 
             ++ (config.my.preservation.ignore.files or []);

      # Combine, deduplicate, and format for bash
      allIgnorePaths = lib.lists.unique (storageLocations ++ targets ++ ignores);
      # Result: `-path '/excluded/path' -prune -o ...`
      ignoreArgs = lib.strings.concatMapStrings (
        ignorePath: "-path ${lib.strings.escapeShellArg ignorePath} -prune -o "
      ) allIgnorePaths;

      # ---Application construction--- #
      find-ephemeral = pkgs.writeShellApplication {
        name = "find-ephemeral";
        runtimeInputs = [
          pkgs.findutils
          pkgs.tree
        ];
        text = lib.replaceStrings ["# syntax: bash\n"] [""] ''
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
  };
}