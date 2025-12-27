{
  pkgs,
  inputs,
  username,
  ...
}:

{
  # --- CORE HOME MANAGER SETTINGS ---
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05"; 
  };

  # --- PACKAGES ---
  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    eza # A modern replacement for ‘ls’
    bat # Better cat with syntax highlighting

    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # Example: Using an input directly (if you had a specific flake input)
    # inputs.some-other-flake.packages.${pkgs.system}.cool-package
  ];

  # --- PROGRAMS ---
  # Git Configuration
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Gwenodai";
        email = "gwenpark37@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
  # Git CLI Configuration
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
  # Starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = true;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };
  # Bash
  programs.bash = {
    enable = true;
    enableCompletion = true;
    # Custom Aliases
    shellAliases = {
      ll = "eza -Al --icons";
      ls = "eza -A --icons";
      cat = "bat";
    };
  };
  # Add the home-manager command to $PATH
  programs.home-manager.enable = true;

  # --- CURSOR ---
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.vimix-cursors;
    name = "Vimix-cursors";
    size = 24;
  };
  xresources.properties = {
    "Xcursor.size" = 24;
  };
}

# --- EXAMPLES ---
# link the configuration file in current directory to the specified location in home directory
# home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

# link all files in `./scripts` to `~/.config/i3/scripts`
# home.file.".config/i3/scripts" = {
#   source = ./scripts;
#   recursive = true;   # link recursively
#   executable = true;  # make all files executable
# };

# encode the file content in nix configuration file directly
# home.file.".xxx".text = ''
#     xxx
# '';