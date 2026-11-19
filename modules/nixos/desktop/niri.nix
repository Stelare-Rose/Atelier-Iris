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
      libqalculate
      wl-mirror
      glib
      adw-gtk3
    ];
    programs.dconf.enable = true;
    programs.kdeconnect.enable = true;
    programs.niri.enable = true;
    hardware.i2c.enable = true;                    
    services.udev.packages = [ pkgs.brightnessctl ];
    users.users.Stelare.extraGroups = [ "i2c" "video" ];
    systemd.user.services.color-scheme = {
      description = "Set light or dark mode by time of day";
      path = [ pkgs.dconf ];
      script = ''
      hour=$(date +%-H)
      if [ "$hour" -ge 18 ] || [ "$hour" -lt 7 ]; then
        scheme=prefer-dark
        theme=adw-gtk3-dark
      else
        scheme=prefer-light
        theme=adw-gtk3
      fi
      dconf write /org/gnome/desktop/interface/color-scheme "'$scheme'"
      dconf write /org/gnome/desktop/interface/gtk-theme "'$theme'"
      '';
      serviceConfig.Type = "oneshot";
      wantedBy = [ "graphical-session.target" ];
    };

    systemd.user.timers.color-scheme = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = [ "*-*-* 07:00" "*-*-* 18:00" ];
        Persistent = true;
      };
    };
  };
}
