# This file defines the base schema for all hosts
{
  den.schema.host =
    { host, lib, ... }:
    {
      options.hardware = lib.mkOption {
        description = "Host hardware profile configuration";
        type =
          with lib.types;
          submodule {
            options = {
              platform = lib.mkOption {
                description = "The physical form factor of the host machine.";
                type = enum [
                  "desktop"
                  "laptop"
                  "server"
                  "htpc"
                ];
                default = "desktop";
              };

              cpu = {
                vendor = lib.mkOption {
                  description = ''
                    CPU vendor for microcode updates and kernel modules.

                    Setting this to `null` disables auto CPU config.
                  '';
                  # NOTE: Currently only "amd" has any functionality
                  type = nullOr (enum [
                    "amd"
                    "intel"
                    "misc"
                  ]);
                  default = null;
                };
                lowLatencyScheduler = lib.mkOption {
                  description = "Prioritise latency performance via kernel params.";
                  type = bool;
                  default = false;
                };
                cores = lib.mkOption {
                  description = "The total number of physical CPU cores available.";
                  type = nullOr ints.positive;
                  default = null;
                };
              };

              gpu = {
                vendor = lib.mkOption {
                  description = ''
                    GPU vendor for drivers and kernel modules.

                    Setting this to `null` disables auto GPU config.
                  '';
                  # NOTE: Currently only "amd" has any functionality
                  type = nullOr (enum [
                    "amd"
                    "nvidia"
                    "intel"
                    "misc"
                  ]);
                  default = null;
                };
                advancedPowerManagement = lib.mkOption {
                  description = "Enables overdrive, full power control and other overclocking features.";
                  type = bool;
                  default = false;
                };
              };

              displays = lib.mkOption {
                description = "The display configuration of the host system.";
                type = nullOr (attrsOf anything);
                default = null;
              };

              touchscreen = lib.mkOption {
                description = "Which display the touchscreen is mapped to.";
                type = nullOr str;
                default = null;
              };
            };
          };
        default = { };
      };
    };
}
