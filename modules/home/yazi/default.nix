{ config, nixcfg, lib, ... }:
let
  cfg = config.home.yazi;
in {
  options.home.yazi.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.utils.enable;
    description = "Enables Yazi (Home manager theme)";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."yazi".source = config.util.link "/dotfiles/yazi";
  };
}
