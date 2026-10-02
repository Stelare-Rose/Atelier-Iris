{ config, nixcfg, lib, ... }:
let
  cfg = config.home.lazygit;
in {
  options.home.lazygit.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.development.utilities.enable;
    description = "Enables lazygit configuration";
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."lazygit/config.yml".source = config.util.link "/dotfiles/lazygit/config.yml";
  };
}
