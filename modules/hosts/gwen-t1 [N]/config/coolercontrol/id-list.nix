# List of UIDs used by coolercontrol
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
    config = lib.optionalAttrs (options.host ? coolercontrol) {
      # --- Hardware Device IDs ---
      host.coolercontrol.id.devices = {
        cpu =
        "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127";
        gpu =
        "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e";
        it8696 = # MB fan controller
        "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803";
        nvme_990pro = # 4TB SSD
        "341fd0f49200232856b962da8ac0e1e21895610be9a6bc48415f27190b412931";
        nvme_970evo = # 1TB SSD
        "62431f8d94059dfab9adce10c509b9beefe28048c4674d7653baeafa72bdb286";
        cust_sens_dev = # Custom sensor device
        "19e098e312e1b1b39163a343ea22b6ea17f18ec1a803ffe0ce44f5bacd6076ee";
        
        # Disabled/Other
        acpitz =
        "f42333b13a2853dfb8e516c576470622e74a4659bfffe7ca229f68733beae979";
        gigabyte_wmi =
        "9a64f7a5c7b59e073064f69eea496b0424b867bb35c843c28825f6d4a73aeba5";
        ethernet =
        "cf77dfb5a9215ce276b33d7e7d63d5b0334aefe1b00eb6baa333f3c63cec1e14";
        spd_1 =
        "425f4db3690287aa7dddd4ea2dd5576fb2ec9665ae005115c3dad7ed0b7370ea";
        spd_2 =
        "fc4182d66cb8b71b330f257eed12cf3efc6e24219b4eeefdcb9b579e07b3f910";
      };

      # --- Profile IDs ---
      host.coolercontrol.id.profiles = {
        aio_fans = "37d94b73-b524-40a3-936a-56e73277722c";
      };

      # --- Function IDs ---
      host.coolercontrol.id.functions = {
        exp_mov_avg = "02ba5ea0-89cc-4085-808f-c3b1cc97963b";
      };

      # --- Custom Sensor IDs ---
      host.coolercontrol.id.sensors = {
        system = "sensor1";
        nvme   = "sensor2";
      };

      # --- Dashboard IDs ---
      host.coolercontrol.id.dash = {
        system = "1ac5dda5-9814-4c37-8566-38d24ddabe3f";
        temps  = "8295db91-15d9-48dd-8295-439948b14511";
        cpu    = "a2ec2663-1755-4cd1-8552-4c906d98b21d";
        gpu    = "0a1b47c5-9643-40c9-838c-b0d2a2de1530";
      };
      
      # --- Alert IDs ---
      host.coolercontrol.id.alerts = {
        cpu = "2030ba2e-d583-4f5c-9118-00df549af2e7";
        gpu = "feac0f69-7051-4dba-aa01-5e7d2adff608";
      };
    };
  };
}