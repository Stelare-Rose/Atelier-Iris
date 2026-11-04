{ config, lib, ctx, ... }:
let
  cfg = config.modules.tailscale;
  root = ctx.root;
in
  {
  options.modules.tailscale.enable = lib.mkEnableOption "wireguard, connecting to Copernicus";

  config = lib.mkIf cfg.enable {
    sops.secrets."tailscale-key" = {
      sopsFile = root + "/secrets/common/tailscale/tailscale.key";
      format = "binary";
    };

    services.tailscale = {
      enable = true;

      authKeyFile = config.sops.secrets."tailscale-key".path;
    };

    networking.nftables.enable = true;
    networking.firewall = {
      enable = true;
      trustedInterfaces = [ config.services.tailscale.interfaceName ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };

    systemd.services.tailscaled.serviceConfig.Environment = [ 
      "TS_DEBUG_FIREWALL_MODE=nftables" 
    ];
  };
}
