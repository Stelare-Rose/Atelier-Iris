{ config, nixcfg, lib, ctx, ... }:
let
  cfg = config.home.pandoc;
  root = ctx.root;
in
  {
  options.home.pandoc.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.office.enable;
    description = "Enables obsidian pandoc config";
  };
  config = lib.mkIf cfg.enable {
    home.file.".local/share/pandoc".source = config.util.link (root + /dotfiles/pandoc);
  };
}
