# Configure LACT manually instead of via `services.lact.settings`
# so that the gui can still be used to apply settings ephemerally
{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    config,
    lib,
    ...
  }: {
    config = lib.mkIf ( config.services.lact.enable or false ) {
      environment.etc = {
        "lact/config.yaml" = {
          mode = "0644";
          text = builtins.replaceStrings ["# syntax: yaml\n"] [""] ''
            # syntax: yaml
            version: 5
            daemon:
              log_level: info
              admin_group: wheel
              disable_clocks_cleanup: false
            apply_settings_timer: 5
            gpus:
              1002:7550-1043:061A-0000:03:00.0:
                fan_control_enabled: true
                fan_control_settings:
                  mode: curve
                  static_speed: 0.5
                  temperature_key: edge
                  interval_ms: 500
                  curve:
                    60: 0.4
                    75: 0.5
                    80: 0.58
                    90: 0.58
                    100: 0.64
                  spindown_delay_ms: 5000
                  change_threshold: 2
                pmfw_options:
                  zero_rpm: false
                power_cap: 317.0
                performance_level: auto
                min_memory_clock: 97
                max_memory_clock: 1259
                gpu_clock_offsets:
                  0: 0
                voltage_offset: 0
            profiles:
              270w-85uv:
                gpus:
                  1002:7550-1043:061A-0000:03:00.0:
                    fan_control_enabled: true
                    fan_control_settings:
                      mode: curve
                      static_speed: 0.5
                      temperature_key: edge
                      interval_ms: 500
                      curve:
                        60: 0.4
                        75: 0.5
                        80: 0.58
                        90: 0.58
                        100: 0.64
                      spindown_delay_ms: 5000
                      change_threshold: 2
                    pmfw_options:
                      zero_rpm: false
                    power_cap: 270.0
                    performance_level: manual
                    min_memory_clock: 97
                    max_memory_clock: 1259
                    gpu_clock_offsets:
                      0: -150
                    voltage_offset: -85
                    power_profile_mode_index: 4
            current_profile: 270w-85uv
            auto_switch_profiles: false
          '';
        };
      };
    };
  };
}