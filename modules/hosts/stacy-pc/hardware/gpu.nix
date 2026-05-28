# Host GPU config
{ lib, ... }:
{
  den.aspects.stacy-pc = {
    nixos.environment.etc."lact/config.yaml" = {
      enable = true;
      text = lib.replaceStrings [ "# syntax: yaml\n" ] [ "" ] ''
        # syntax: yaml
        version: 5
        daemon:
          log_level: info
          admin_group: wheel
          disable_clocks_cleanup: false
        apply_settings_timer: 5
        gpus:
          1002:73BF-1EAE:6705-0000:03:00.0:
            fan_control_enabled: false
            performance_level: auto
            max_core_clock: 2105
        profiles:
          200w-20uv:
            gpus:
              1002:73BF-1EAE:6705-0000:03:00.0:
                fan_control_enabled: true
                fan_control_settings:
                  mode: curve
                  static_speed: 0.7
                  temperature_key: junction
                  interval_ms: 500
                  curve:
                    60: 0.3
                    75: 0.4
                    80: 0.5
                    90: 0.5
                    95: 0.6
                    98: 0.6
                    100: 0.7
                  spindown_delay_ms: 5000
                  change_threshold: 2
                power_cap: 200.0
                performance_level: manual
                max_core_clock: 2105
                voltage_offset: -20
                power_profile_mode_index: 4
        current_profile: 200w-20uv
        auto_switch_profiles: false
      '';
    };
  };
}
