# Defines all hosts + users + homes
{ den, ... }:{
  # Gwen PC
  den.hosts.x86_64-linux.gwen-t1.users = {
    gwen.classes = [ "homeManager" ];
    # stacy.classes = [ "homeManager" ];
    # tempUser = {};
  };
  # Server
  den.hosts.x86_64-linux.ymir.users = {
    gwen = {};
  };
  # Stacy PC
  den.hosts.x86_64-linux.stacy-pc.users = {
    stacy.classes = [ "homeManager" ];
  };

  # Default host settings
  den.ctx.host = {
    includes = [
      den._.hostname # Automatically set hostname based on host
    ];
  };
}