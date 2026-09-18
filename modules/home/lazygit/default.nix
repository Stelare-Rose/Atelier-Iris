{ config, nixcfg, lib, ctx, ... }:
let
  cfg = config.home.lazygit;
  root = ctx.root;
in {
  options.home.lazygit.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.development.utilities.enable;
    description = "Enables lazygit configuration";
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."lazygit/config.yml".source = config.util.link (root + /dotfiles/lazygit/config.yml);
  };
}
