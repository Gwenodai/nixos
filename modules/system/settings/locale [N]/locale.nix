{
  # Locale config
  flake.modules.nixos.locale = { ... }: {
    time.timeZone = "Australia/Sydney";
    i18n.defaultLocale = "en_AU.UTF-8";
    console.keyMap = "us";
  };
}