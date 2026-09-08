{config, lib, ...}:
let
  cfg = config.modules.networking;
in 
  {
  options.modules.networking.enable = lib.mkEnableOption "networking with 1.1.1.1 dns";
  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      usePredictableInterfaceNames = false;
      nameservers = [ "1.1.1.1" ];
      useNetworkd = true;
    };
  };
}
