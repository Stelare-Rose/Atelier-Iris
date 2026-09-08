{ config, lib, pkgs, ... }:
{
  config = lib.mkIf config.modules.desktop.enable {
    environment.systemPackages = with pkgs; [
      wlsunset
      wl-clipboard
      wezterm
    ];
    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;
    security = {
      polkit.enable = true;
      pam.services.hyprlock = {};
    };
  };
}
