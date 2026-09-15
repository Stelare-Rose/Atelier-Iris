{ config, lib, ... }:
let
  cfg = config.modules.networking;
in 
  {
  options.modules.networking.enable = lib.mkEnableOption "networking with 1.1.1.1 dns";
  config = lib.mkMerge [
    (lib.mkIf config.modules.user.enable {
      users.users.Stelare.extraGroups = [ "networkmanager" ];
    })
    (lib.mkIf cfg.enable {
      nixpkgs.config.allowUnfree = true;
      networking = {
        networkmanager.enable = true;
        usePredictableInterfaceNames = false;
        nameservers = [ "1.1.1.1" ];
        useNetworkd = true;
      };
      services.cloudflare-warp = {
        enable = true;
      };
      services.vnstat.enable = true;
    })
  ];
}
