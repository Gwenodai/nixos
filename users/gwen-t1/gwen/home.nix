{
  username,
  ...
}:

{
  # --- CORE HOME MANAGER SETTINGS ---
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05"; 
  };
}

# TODO: Import optional modules

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