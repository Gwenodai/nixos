# A simple tool to list all files not preserved via preservation in any given directory
{
  flake.modules.nixos.preservation = {
    pkgs,
    lib,
    config,
    ...
  }: {
    config = lib.mkIf config.preservation.enable (
      let
        getPreservedPaths =
          preservationConfig:
          let
            stores = builtins.attrValues (preservationConfig.preserveAt or {});
            
            getPath =
              x: 
              if builtins.isString x then
                x
              else if x ? directory then
                x.directory
              else
                x.file;

            getEntries = store: (store.directories or []) ++ (store.files or []);
            allEntries = builtins.concatMap getEntries stores;
          in
          builtins.map (x: getPath x) allEntries;

        systemPersistentStorageDirs = builtins.attrNames (config.preservation.preserveAt or {});
        hmPersistentStorageDirs =
          let
            hmUsers = config.home-manager.users or {};
            getUserStorage = _: userConfig:
              builtins.attrNames (userConfig.home.preservation.preserveAt or {});
          in
          lib.lists.flatten (lib.mapAttrsToList getUserStorage hmUsers);

        systemPaths = getPreservedPaths config.preservation;

        hmPaths =
          let
            hmUsers = config.home-manager.users or {};
            userPaths =
              username: userConfig:
              let
                userHome = config.users.users.${username}.home;
                relativePaths = getPreservedPaths userConfig.home.preservation;
              in
              builtins.map (x: "${userHome}/${x}") relativePaths;
          in
          lib.lists.flatten (lib.mapAttrsToList userPaths hmUsers);

        ignore-directories = [
          "/boot"
          "/nix"
          "/proc"
          "/run"
          "/sys"
          "/tmp"
          "/var/log"
        ]
        ++ systemPersistentStorageDirs
        ++ hmPersistentStorageDirs
        ++ systemPaths
        ++ hmPaths;

        find-ephemeral = pkgs.writeShellApplication {
          name = "find-ephemeral";
          runtimeInputs = [ pkgs.tree ];
          text = ''
            show_tree=0
            search_dir=""

            while [[ $# -gt 0 ]]; do
              case $1 in
                -t|--tree)
                  show_tree=1
                  shift
                  ;;
                *)
                  search_dir="$1"
                  shift
                  ;;
              esac
            done

            search_dir="''${search_dir:-$HOME}"

            run_search() {
              find "$search_dir" \
                -xdev \
                ${lib.strings.concatMapStrings (x: "-path '${x}' -prune -o ") ignore-directories} \
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
      }
    );
  };
}