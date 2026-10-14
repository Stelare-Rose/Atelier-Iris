{ config, lib, pkgs, ... }:
{
  config = lib.mkIf config.modules.desktop.niri.enable {
    environment.systemPackages = with pkgs; [
      wlsunset
      wezterm
      libinput
      wayland-utils
      waybar
      hyprlock
      wl-clipboard-rs
      swaynotificationcenter
      xwayland-satellite
      libnotify
    ];
    programs.niri.enable = true;
  };
}
