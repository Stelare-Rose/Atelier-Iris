{ config, lib, pkgs, ... }:
{
  config = lib.mkIf config.modules.desktop.enable {
    environment.systemPackages = with pkgs; [
      wlsunset
      wezterm
      wl-clipboard-rs
      libinput
      wayland-utils
      waybar
      hyprpaper
      hyprshot
      swaynotificationcenter
      nvd
      catppuccin-cursors.mochaLavender
    ];
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    security = {
      polkit.enable = true;
      pam.services.hyprlock = {};
    };
  };
}
