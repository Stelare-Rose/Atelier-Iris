{ config, lib, pkgs, ... }:
let
  cfg = config.modules.ssh;
in
  {
  options.modules.ssh.enable = lib.mkEnableOption "openSSH and opens relevant ports";
  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}
