{ config, nixcfg, lib, ... }:
let
  cfg = config.home.niri;
in
{
  options.home.niri.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.desktop.niri.enable;
    description = "Enables niri";
  };

  config = lib.mkIf cfg.enable {
    services.awww.enable = true;
    xdg.configFile."niri/config.kdl".source = config.util.link "/dotfiles/niri/config.kdl";
    xdg.configFile."niri/backgrounds".source = config.util.link "/dotfiles/backgrounds";
  };
}
