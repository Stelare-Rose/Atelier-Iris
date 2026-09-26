{ config, lib, pkgs, ... }:
{
  config = lib.mkIf config.modules.desktop.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ 
        xdg-desktop-portal-gtk 
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-wlr
      ] ++ lib.optional config.modules.utils.enable xdg-desktop-portal-termfilechooser;
    };
  };
}
