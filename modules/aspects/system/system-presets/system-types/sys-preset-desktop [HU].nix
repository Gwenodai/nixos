# Preset system types.
# These should be imported by BOTH hosts and users wanting to use them.
{ __findFile, den, ... }:
let
  # Make sure to pick a `desktop-type` if you pick a desktop system preset
  desktop = {
    includes = with den.aspects; [
      sys-preset-basic # Inherit `basic` system-type
      # ---Core Aspects--- #
      gdm
      audio
      fonts
      # Security aspects
      gnome-keyring
      polkit-gnome

      # ---Basic Desktop Applications--- #
      kitty
      nemo
      google-chrome
      <vscode> # TODO: Replace with sublime text for regular desktop use
      <vscode/config>
    ];
  };

  # Desktop system variant that incorporates extras for gaming systems
  gaming = {
    includes = with den.aspects; [
      # ---Core Aspects--- #
      graphics
      lact # GPU control
      ananicy # Auto-nice daemon

      # ---Hardware--- #
      (den.lib.perHost { nixos.hardware.xone.enable = true; }) # Xbox One controllers

      # ---Gaming Related Applications--- #
      steam
      <heroic>
      <heroic/config>
      umu-launcher
      mangohud
      <vesktop>
      <vesktop/config>
    ];

  };
in
{
  den.aspects.sys-preset-desktop.includes = [ desktop ];
  den.aspects.sys-preset-desktop._.gaming.includes = [ gaming ];
}
