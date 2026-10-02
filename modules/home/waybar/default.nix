{ config, nixcfg, lib, ... }:
let
  cfg = config.home.waybar;
in {
  options.home.waybar.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.desktop.enable;
    description = "Enables Waybar";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."waybar".source = config.util.link "/dotfiles/waybar";
  };
}
