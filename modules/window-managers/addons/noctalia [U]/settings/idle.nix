{ inputs, den, ... }:
{
  den.aspects.noctalia._.settings._.idle = den.lib.perUser {
    homeManager =
      { config, ... }:
      {
        programs.noctalia-shell.settings = {
          # ---Noctalia idle settings---
          idle = inputs.self.lib.applyDefaults {
            enabled = true;
            fadeDuration = 5; # Fade to black over 'x' seconds before doing any of the following

            # Screen off (Time in seconds)
            screenOffTimeout = 180;
            screenOffCommand = "";
            resumeScreenOffCommand = "";

            # Lockscreen (Time in seconds)
            lockTimeout = 300;
            lockCommand = "";
            resumeLockCommand = "";

            # Sleep (Time in seconds)
            suspendTimeout = 0;
            suspendCommand = "";
            resumeSuspendCommand = "";

            # Custom shell commands
            customCommands = "[]";
          };
        };
      };
  };
}
