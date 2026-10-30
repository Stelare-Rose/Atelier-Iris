{ config, lib, ... }:
let
  cfg = config.modules.networking;
in 
  {
  options.modules.networking.enable = lib.mkEnableOption "networking with 1.1.1.1 dns";
  config = lib.mkMerge [
    (lib.mkIf (config.modules.user.enable && cfg.enable) {
      users.users.Stelare.extraGroups = [ "networkmanager" ];
    })
    (lib.mkIf cfg.enable {
      nixpkgs.config.allowUnfree = true;
      services.resolved = {
        enable = true;
        dnssec = "allow-downgrade";
        dnsovertls = "opportunistic"; 
        fallbackDns = [ "1.0.0.1" ];
        domains = [ "~." ];
      };

      networking = {
        networkmanager = {
          enable = true;
          dns = "systemd-resolved";
        };
        usePredictableInterfaceNames = false;
        nameservers = [ 
          "1.1.1.1#one.one.one.one"
          "1.0.0.1#one.one.one.one"
        ];
        useNetworkd = true;
      };
      services.cloudflare-warp = {
        enable = true;
      };
      services.vnstat.enable = true;
      systemd.network.wait-online.enable = lib.mkDefault false;
      systemd.services.NetworkManager-wait-online.enable = lib.mkDefault false;
    })
  ];
}
