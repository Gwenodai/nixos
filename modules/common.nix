{
  pkgs,
  inputs,
  username,
  ...
}:

{
  # --- BASIC SYSTEM SETTINGS ---
  system.stateVersion = "25.05";
  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  
  # --- GARBAGE COLLECTION ---
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  # Hard link identical files to save space
  nix.settings.auto-optimise-store = true;

  # --- LOCALISATION ---
  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";
  console.keyMap = "us";

  # --- USER ---
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "wheel"
      "networkmanager" 
    ];
  };
  # Ensure user group exists
  users.groups.${username} = {};

  # --- SYSTEM PACKAGES FOR ALL MACHINES ---
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    git
  ];

  # --- SHELL CONFIG ---
  # programs.zsh.enable = false;
  programs.bash.enable = true;
  # users.defaultUserShell = pkgs.zsh;

  # --- SSH SETUP ---
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
    };
  };
}