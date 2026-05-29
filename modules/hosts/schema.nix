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
                arch = lib.mkOption {
                  description = "Microarchitecture targeting specific kernel builds (e.g., CachyOS).";
                  type = nullOr (enum [
                    "x86-64-v3"
                    "x86-64-v4"
                    "zen3"
                    "zen4"
                    "skylake"
                  ]);
                  default = null;
                };
                lowLatencyScheduler = lib.mkOption {
                  description = "Prioritise latency performance via kernel params.";
                  type = bool;
                  default = false;
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
            };
          };
        default = { };
      };

    };
}
