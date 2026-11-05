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
      xwayland-satellite
      libnotify
      ddcutil
      brightnessctl
      pulseaudio
    ];
    programs.niri.enable = true;
    hardware.i2c.enable = true;                    
    services.udev.packages = [ pkgs.brightnessctl ];
    users.users.Stelare.extraGroups = [ "i2c" "video" ];
  };
}
