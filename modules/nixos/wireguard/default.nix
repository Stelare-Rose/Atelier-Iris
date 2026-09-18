{ config, lib, ... }:
let
  cfg = config.modules.wireguard;
in
  {
  options.modules.wireguard.enable = lib.mkEnableOption "wireguard, connecting to Copernicus";
  options.modules.wireguard.secretPath = lib.mkOption {
    type = lib.types.nullOr lib.types.path;
    default = null;
    description = "Path to the sops file containing the wireguard config";
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.secretPath != null;
        message = "Wireguard requires secret file to be set";
      } 
    ];
    sops.secrets."wg0-conf" = {
      sopsFile = cfg.secretPath;
      format = "binary";
      path = "/run/secrets/wg0.conf";
    };
    networking.firewall = {
      allowedUDPPorts = [ 51820 ];
    };

    systemd.services."wg-quick-wg0" = {
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };
    
    networking.wg-quick.interfaces.wg0.configFile = lib.mkDefault config.sops.secrets."wg0-conf".path;
  };
}
