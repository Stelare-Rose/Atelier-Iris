{ config, nixcfg, lib, ctx, ... }:
let
  cfg = config.home.fastfetch;
  root = ctx.root;
in {
  options.home.fastfetch.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.shell.enable;
    description = "Enables fastfetch";
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."fastfetch".source = config.util.link (root + /dotfiles/fastfetch);
  };
}
