{ config, nixcfg, lib, ctx, ... }:
let
  cfg = config.home.starship;
  root = ctx.root;
in {
  options.home.starship.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.shell.enable;
    description = "Enables Starship (Home manager theme)";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."starship.toml".source = config.util.link (root + /dotfiles/starship/starship.toml);
  };
}
