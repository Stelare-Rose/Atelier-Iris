{ config, lib, pkgs, ... }:
let
  cfg = config.modules.utils;
in
  {
  options.modules.utils.enable = lib.mkEnableOption "various utility packages";
  options.modules.utils.gui.enable = lib.mkEnableOption "various gui utility packages";
  config = lib.mkMerge [
    (lib.mkIf (cfg.enable && config.modules.user.enable) {
      users.users.Stelare.extraGroups = [ "video" "i2c" ];
    })
    (lib.mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        uutils-coreutils-noprefix
        dotool
        appimage-run
        yazi
        sops
        tmux
        asciinema
        ddcutil
        brightnessctl
      ];
    })
    (lib.mkIf cfg.gui.enable {
      environment.systemPackages = with pkgs; [
        via
        nautilus
        bitwarden-desktop
      ];
    })
  ];
}
