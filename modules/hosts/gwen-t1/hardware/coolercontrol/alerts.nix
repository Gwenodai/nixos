{ lib, ... }:
{
  den.aspects.gwen-t1 = {
    coolercontrol-alerts.text =
      let
        ### Hardware device IDs
        cpu = # 9800X3D
          "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127";
        gpu = # 9070 XT
          "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e";
      in
      # Stupid extension... Nix highlighting is close enough to make toml readable
      lib.replaceStrings [ "# syntax: json\n" ] [ "" ] ''
        # syntax: json
        {
          "alerts": [
            {
              "uid": "2030ba2e-d583-4f5c-9118-00df549af2e7",
              "name": "CPU Throttling",
              "channel_source": {
                "device_uid": "${cpu}",
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
              "uid": "feac0f69-7051-4dba-aa01-5e7d2adff608",
              "name": "GPU Throttling",
              "channel_source": {
                "device_uid": "${gpu}",
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
}
