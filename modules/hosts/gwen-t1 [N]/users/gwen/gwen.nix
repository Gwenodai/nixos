{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    ...
  }: {
    # Nixos module imports
    imports = with inputs.self.modules.nixos; [
      gwen # Import host agnostic user config
      desktop-niri
    ];
    # Home Manager module imports
    home-manager.users.gwen.imports = with inputs.self.modules.homeManager; [
      desktop-niri
    ];
    
    # TODO: Secret
    nix.extraOptions = ''
      !include /persist/secrets/access-tokens.secret
    '';
  };
}