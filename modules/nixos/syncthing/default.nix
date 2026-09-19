{ config, lib, ... }:
let
  cfg = config.modules.syncthing;
in
  {
  options.modules.syncthing.enable = lib.mkEnableOption "syncthing and opens relevant ports";
  config = lib.mkIf cfg.enable {
    services.syncthing = {
      dataDir = lib.mkIf config.modules.user.enable "/home/Stelare/Sync";
      enable = true;
      openDefaultPorts = true;
      user = lib.mkIf config.modules.user.enable "Stelare";
    };
  };
}
