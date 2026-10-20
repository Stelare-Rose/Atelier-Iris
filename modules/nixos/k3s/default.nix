{ config, lib, pkgs, ... }:
let
  cfg = config.modules.k3s;
in {
  options.modules.k3s.enable = lib.mkEnableOption "k3s";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.fluxcd ];
    networking.firewall.allowedTCPPorts = [
      6443 
    ];
    services.k3s.enable = true;
    services.k3s.role = "server";
    services.k3s.extraFlags = [ "--write-kubeconfig-mode=644" ];
  };
}
