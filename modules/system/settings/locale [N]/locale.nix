# Locale config
{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.locale = {
    lib,
    ...
  }: {
    time.timeZone = lib.mkDefault "Australia/Sydney";
    i18n.defaultLocale = lib.mkDefault "en_AU.UTF-8";
    console.keyMap = lib.mkDefault "us";
  };
}