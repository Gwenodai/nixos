{
  den.aspects.stacy-pc._.to-users = {
    homeManager =
      { lib, ... }:
      {
        programs.mangohud.settings.fps_limit = lib.mkForce [
          138 # (REFRESH×(1−REFRESH×0.00028))
          0
          120
          60
          30
        ];
      };
  };
}
