{ inputs, den, ... }: {

  den.aspects.cli = {
    includes = with den.aspects.cli.provides; [
      pkgs
      nh
      direnv
      eza
      bat
    ];

    provides.pkgs = { host, ... }: {
      nixos = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
          parted # CLI program for creating and manipulating partition tables
          file   # Program that shows the type of files
          tree   # Command to produce a depth indented directory listing
          which  # Shows the full path of (shell) commands
          wget   # Tool for retrieving files using HTTP, HTTPS, and FTP
          curl   # Command line tool for transferring files with URL syntax
          gnused # GNU sed, a batch stream editor
          gawk   # GNU implementation of the Awk programming language
          jq     # Lightweight and flexible command-line JSON processor
        ];
      };
    };

    provides.nh = { host, user, ... }: {
      homeManager = { config, lib, ... }: {
        programs.nh = {
          enable = lib.mkDefault true;
          clean = {
            enable = lib.mkDefault true;
            extraArgs = lib.mkDefault "--keep-since 30d --keep 3";
          };
          flake = lib.mkDefault "${config.home.homeDirectory}/dots";
          osFlake = lib.mkDefault "${config.home.homeDirectory}/dots";
          homeFlake = lib.mkDefault "${config.home.homeDirectory}/dots";
        };
      };
    };
    
    provides.direnv = { host, user, ... }: {
      homeManager = { lib, ... }: {
        programs.direnv = {
          enable = lib.mkDefault true;
          nix-direnv.enable = lib.mkDefault true;
        };
      };
      persistUser = { hmConfig, ... }: {
        directories = [
          {
            directory = "${hmConfig.xdg.dataHome}/direnv/allow";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };
      persistUserTmp = { hmConfig, ... }: {
        ".local" = {};                   # "~/.local"
        "${hmConfig.xdg.dataHome}" = {}; # "~/.local/share"
        "${hmConfig.xdg.dataHome}/direnv" = {};
      };
    };

    provides.bat = { host, user, ... }: {
      homeManager = { pkgs, lib, ... }: {
        programs.bat = {
          enable = lib.mkDefault true;
          config.theme = lib.mkDefault "Monokai Extended";

          extraPackages = with pkgs.bat-extras; [
            batman # Read system manual pages (man) using bat as the manual page formatter
            batgrep # Quickly search through and highlight files using ripgrep
            batdiff # Diff a file against the current git index, or display the diff between two files
            batpipe # Less (and soon bat) preprocessor for viewing more types of files in the terminal
            batwatch # Watch for changes in one or more files, and print them with bat
            prettybat # Pretty-print source code
          ];
        };
        # Custom aliases
        home.shellAliases = inputs.self.lib.applyDefaults {
          cat = "bat";
          man = "batman";
          # Make batgrep properly scale to terminal width
          grep = "batgrep --terminal-width=$(( $(echo $COLUMNS) - 8 ))";
          diff = "batdiff";
          less = "batpipe";
          watch = "batwatch";
        };
      };
      persistUserIgnore = { hmConfig, ... }: {
        directories = [ "${hmConfig.xdg.cacheHome}/bat" ];
        files = [ "${hmConfig.xdg.stateHome}/lesshst" ];
      };
    };

    provides.eza = { host, user, ... }: {
      homeManager = { lib, ... }: {
        # TODO: Configure eza
        programs.eza = inputs.self.lib.applyDefaults {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
          icons = "always";
          git = true;
          extraOptions = [
            "--group-directories-first"
            "--header"
          ];
        };
      };
    };
  };
}
