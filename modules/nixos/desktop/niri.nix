{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.modules.desktop.niri.enable && config.modules.desktop.enable) {
    environment.systemPackages = with pkgs; [
      wlsunset
      wezterm
      libinput
      wayland-utils
      waybar
      hyprlock
      wl-clipboard
      cliphist
      wl-clip-persist
      dmenu
      swaynotificationcenter
      xwayland-satellite
      libnotify
    ];
    programs.niri.enable = true;
  };
}
