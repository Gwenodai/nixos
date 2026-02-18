# Define options for declaring files to be ignored by `find-ephemeral`
{
  lib,
  ...
}: let
  sharedOptions = {
    preservation.ignore = lib.mkOption {
      default = {};
      type = with lib.types; submodule {
        options = {
          directories = lib.mkOption {
            type = listOf str;
            default = [];
          };
          files = lib.mkOption {
            type = listOf str;
            default = [];
          };
        };
      };
    };
  };
  in {
  # --- NIXOS MODULE ---
  flake.modules.nixos.preservation = {
    ...
  }: {
    options = sharedOptions;
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.preservation = {
    ...
  }: {
    options = sharedOptions;
  };
}