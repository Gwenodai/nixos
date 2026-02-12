# A simple tool to list all files not preserved via preservation in any given directory
{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.preservation = {
    pkgs,
    lib,
    config,
    ...
  }: let
    # Retrieve declared preservation paths from raw `preservationConfig` input
    getPreservationTargets = preservationConfig:
      let
        # Store the raw values contained in `preservationConfig.preserveAt`
        rawEntries = builtins.attrValues (preservationConfig.preserveAt or {});
        # Filter input and only return attributes containing directory or file objects
        filterEntries = x: (x.directories or []) ++ (x.files or []);
        # Returns a mixed list of objects and strings
        filteredList = builtins.concatMap filterEntries rawEntries;
        # Takes filtered input and returns only the preservation target
        getTarget = x: 
          if builtins.isString x then # A plain string can only be a preservation target
            x                         # └─Return the untouched variable
          else if x ? directory then  # Check if input has the directory attribute
            x.directory               # └─Return the variable of the directory attribute
          else                        # Input must have file attribute
            x.file;                   # └─Return the variable of the file attribute
      in
      builtins.map (x: getTarget x) filteredList; # Pass everything in `filteredList` to `getTarget`

    # System `preservationConfig.preserveAt` path
    sysEternalPerstistDir = builtins.attrNames (config.preservation.preserveAt or {});
    # Home Manager `preservationConfig.preserveAt` path
    hmEternalPerstistDir =
      let
        hmUsers = config.home-manager.users or {};
        getUserStorage = _: userConfig:
          builtins.attrNames (userConfig.home.preservation.preserveAt or {});
      in
      lib.lists.flatten (lib.mapAttrsToList getUserStorage hmUsers);

    # System preservation target paths
    sysPersistTarget = getPreservationTargets config.preservation;
    # System preservation target paths
    hmPersistTarget =
      let
        hmUsers = config.home-manager.users or {};
        userPaths =
          username: userConfig:
          let
            userHome = config.users.users.${username}.home;
            relativePaths = getPreservationTargets userConfig.home.preservation;
          in
          builtins.map (x: "${userHome}/${x}") relativePaths;
      in
      lib.lists.flatten (lib.mapAttrsToList userPaths hmUsers);

    # Static list of paths not worth scanning
    ignore-paths = [
      "/boot"
      "/nix"
      "/proc"
      "/run"
      "/sys"
      "/tmp"
      "/var/log"
    ]
    # Append paths gathered from preservation configuration 
    ++ sysEternalPerstistDir
    ++ hmEternalPerstistDir
    ++ sysPersistTarget
    ++ hmPersistTarget;

    # Create a shell application to find all files that aren't declared on the `ignore-paths` list
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

        abs_dir="$(realpath "$input_dir")"

        run_search() {
          find "$abs_dir" \
            -xdev \
            ${lib.strings.concatMapStrings (x: "-path '${x}' -prune -o ") ignore-paths} \
            -type f -printf "%p\\n"
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