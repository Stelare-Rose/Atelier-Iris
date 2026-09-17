{ config, lib, ... }:
let
  cfg = config.modules.wireguard;
in
  {
  options.modules.wireguard.enable = lib.mkEnableOption "wireguard, connecting to Copernicus";
  options.modules.wireguard.ipAddress = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "IP Address for this device on Wireguard network";
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.ipAddress != "";
        message = "Wireguard requires ip address to be set";
      } 
    ];
    networking.firewall = {
      allowedUDPPorts = [ 51820 ];
    };

    networking.wireguard.interfaces = {
      wg0 = {
        ips = [cfg.ipAddress];
        listenPort = 51820;

        privateKeyFile = "[placeholder]";
        peers = [
          {
            publicKey = "[placeholder]";
            allowedIPs = ["10.255.0.0/16"];
            endpoint = "[placeholder]";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
