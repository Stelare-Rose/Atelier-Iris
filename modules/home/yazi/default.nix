{ config, nixcfg, lib, ctx, ... }:
let
  cfg = config.home.yazi;
  root = ctx.root;
in {
  options.home.yazi.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.utils.enable;
    description = "Enables Yazi (Home manager theme)";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."yazi".source = config.util.link (root + /dotfiles/yazi);
  };
}
