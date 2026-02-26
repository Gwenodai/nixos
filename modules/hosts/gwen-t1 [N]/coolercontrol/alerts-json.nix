{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    options,
    config,
    lib,
    ...
  }: {
    config = lib.mkIf ( config.programs.coolercontrol.enable or false ) (
      let
        id = config.host.coolercontrol.id;
      in {
        environment.etc = {
          "coolercontrol/alerts.json" = {
            mode = "0644";
            text = builtins.replaceStrings ["# syntax: json\n"] [""] ''
              # syntax: json
              {
                "alerts": [
                  {
                    "uid": "${id.alerts.cpu}",
                    "name": "CPU Throttling",
                    "channel_source": {
                      "device_uid": "${id.devices.cpu}",
                      "channel_name": "temp1",
                      "channel_metric": "Temp"
                    },
                    "min": 0,
                    "max": 94.9,
                    "state": "Inactive",
                    "warmup_duration": 5,
                    "desktop_notify": true,
                    "desktop_notify_recovery": true,
                    "desktop_notify_audio": true,
                    "shutdown_on_activation": false
                  },
                  {
                    "uid": "${id.alerts.gpu}",
                    "name": "GPU Throttling",
                    "channel_source": {
                      "device_uid": "${id.devices.gpu}",
                      "channel_name": "temp2",
                      "channel_metric": "Temp"
                    },
                    "min": 0,
                    "max": 99.9,
                    "state": "Inactive",
                    "warmup_duration": 5,
                    "desktop_notify": true,
                    "desktop_notify_recovery": true,
                    "desktop_notify_audio": true,
                    "shutdown_on_activation": false
                  }
                ],
                "logs": []
              }
            '';
          };
        };
      }
    );
  };
}