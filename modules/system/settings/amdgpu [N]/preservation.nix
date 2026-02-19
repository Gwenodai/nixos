{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.amdgpu = {
    options,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      # Import the Home Manager module automatically
      home-manager.sharedModules = [
        inputs.self.modules.homeManager.amdgpu
      ];
    };
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.amdgpu = {
    options,
    config,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation.ignore.directories = [
        "${config.xdg.cacheHome}/mesa_shader_cache"
        "${config.xdg.cacheHome}/radv_builtin_shaders"
      ];
    };
  };
}