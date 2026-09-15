{ config, nixcfg, lib, ctx, options, ... }:
let
  cfg = config.home.hyprland;
  mon = cfg.monitor;
  root = ctx.root;
in
  {
  options.home.hyprland.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.desktop.enable;
    description = "Enables the home-manager side of hyprland";
  };
  options.home.hyprland.monitor.width = lib.mkOption {
    type = lib.types.int;
    default = 1920;
    description = "Sets the width for the monitor on hyprland";
  };
  options.home.hyprland.monitor.height = lib.mkOption {
    type = lib.types.int;
    default = 1080;
    description = "Sets the height for the monitor on hyprland";
  };
  options.home.hyprland.monitor.name = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "Sets the name for the monitor on hyprland";
  };
  options.home.hyprland.monitor.refresh = lib.mkOption {
    type = lib.types.int;
    default = 60;
    description = "Sets the refresh rate for the monitor on hyprland";
  };
  options.home.hyprland.monitor.autoMode = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Sets monitor to auto mode";
  };
  config = lib.mkMerge [
    {
      warnings = lib.optional
        (cfg.monitor.autoMode && !(
          cfg.monitor.width == 1920 ||
          cfg.monitor.height == 1080 ||
          cfg.monitor.name == "" ||
          cfg.monitor.refresh == false
        )) 
        "Monitor Width, Height, Name, or Refresh is set with Auto Mode enabled. Note that monitor setting will be overriden by auto mode.";
    }
    (lib.mkIf cfg.enable {
      xdg.configFile."hypr/hyprlock.conf".source = config.util.link (root + /dotfiles/hypr/hyprlock.conf); 
      xdg.configFile."hypr/hyprland.conf".source = config.util.link (root + /dotfiles/hypr/hyprland.conf); 
      xdg.configFile."hypr/monitor.conf".text = if cfg.monitor.autoMode 
        then "monitor = , preferred, auto" 
      else "monitor = ${mon.name}, ${toString mon.width}x${toString mon.height}@${toString mon.refresh}, 0x0, 1";
      # Directories
      xdg.configFile."hypr/auxiliary".source = config.util.link (root + /dotfiles/hypr/auxiliary); 
      xdg.configFile."hypr/backgrounds".source = config.util.link (root + /dotfiles/hypr/backgrounds);

      # Nix-Managed
      programs.waybar.enable = true;
      services.hyprpaper = {
        enable = true;
        settings = {
          ipc = "on";
          splash = false;
          wallpaper = {
            monitor = "";
            path = "~/.config/hypr/backgrounds/background.jpg";
          };
        };
      };
    })
  ];
}
