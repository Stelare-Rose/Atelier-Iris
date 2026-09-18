{ config, nixcfg, lib, ctx, ... }:
let
  cfg = config.home.waybar;
  root = ctx.root;
in {
  options.home.waybar.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.desktop.enable;
    description = "Enables Waybar";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."waybar".source = config.util.link (root + /dotfiles/waybar);
  };
}
