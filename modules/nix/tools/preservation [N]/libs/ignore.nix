# Define options for declaring files to be ignored by `find-ephemeral`
{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.preservation = {
    lib,
    ...
  }: {
    options = {
      preservation.ignore = with lib; mkOption {
        default = {};
        type = with types; submodule {
          options = {
            directories = mkOption {
              type = listOf str;
              default = [];
            };

            files = mkOption {
              type = listOf str;
              default = [];
            };
          };
        };
      };
    };
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.preservation = {
    lib,
    ...
  }: {
    options = {
      preservation.ignore = with lib; mkOption {
        default = {};
        type = with types; submodule {
          options = {
            directories = mkOption {
              type = listOf str;
              default = [];
            };

            files = mkOption {
              type = listOf str;
              default = [];
            };
          };
        };
      };
    };
  };
}