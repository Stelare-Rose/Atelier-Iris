{ config, nixcfg, lib, ctx, ... }:
let
  cfg = config.home.termfilechooser;
  root = ctx.root;
in
  {
  options.home.termfilechooser.enable = lib.mkOption {
    type = lib.types.bool;
    default = (nixcfg.modules.utils.enable && nixcfg.modules.desktop.enable);
    description = "Enables termfilechooser config";
  };
  config = lib.mkIf cfg.enable {
    xdg.portal.config.common =
      {
        "default" = [ "hyprland" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
    xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
      force = true;
      source = config.util.link (root + /dotfiles/termfilechooser/config);
    };
    xdg.configFile."termfilechooser/yazi-wrapper.sh".source = config.util.link (root + /dotfiles/termfilechooser/yazi-wrapper.sh);
  };
}
