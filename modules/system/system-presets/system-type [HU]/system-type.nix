# Preset system types.
# These should be imported by BOTH hosts and users wanting to use them.
{ den, ... }: {
  den.aspects.system-type = {

    _.basic = {
      includes = with den.aspects; [
        # ---Core Config--- #
        nix-config
        hardware._.firmware

        # ---Basic Tools--- #
        coolercontrol
        cli
        shell
        git
      ];
    };

    # Make sure to pick a `desktop-type` if you pick a desktop system preset
    _.desktop = {
      includes = with den.aspects; [
        system-type._.basic # Inherit `basic` system-type
        # ---Core Aspects--- #
        display-manager
        audio
        fonts
        # Security
        keyring
        polkit
        
        # ---Basic Desktop Applications--- #
        terminal
        files
        browser
        vscode # TODO: Replace with sublime text for regular desktop use
      ];

      # Desktop system variant that incorporates extras for gaming systems
      _.gaming = {
        includes = with den.aspects; [
          system-type._.desktop # Inherit `desktop` system-type
          # ---Core Aspects--- #
          hardware._.graphics
          lact    # GPU control
          ananicy # Auto-nice daemon

          # ---Gaming Related Applications--- #
          messaging._.discord
        ];
      };
    };
  };
}
