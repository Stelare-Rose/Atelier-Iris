{ config, lib, pkgs, ... }:
let 
  cfg = config.modules.virtualisation;
in 
  {
  options.modules.virtualisation.enable = lib.mkEnableOption "virtualisation support (libvirt, docker, virt-manager)";
  config = lib.mkMerge [ 
    (lib.mkIf config.modules.user.enable {
      users.users.Stelare.extraGroups = [ "libvirtd" "docker" ];
    })
    (lib.mkIf cfg.enable {
      virtualisation = {
        libvirtd = {
          enable = true;
          qemu.package = pkgs.qemu_kvm;
        };
        docker.enable = true;
      };
      environment.systemPackages = with pkgs; [
        virt-manager
      ];
    })
  ];
}
