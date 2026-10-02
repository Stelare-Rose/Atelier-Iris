{ config, nixcfg, lib, ... }:
let
  cfg = config.home.pandoc;
in
  {
  options.home.pandoc.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.office.enable;
    description = "Enables obsidian pandoc config";
  };
  config = lib.mkIf cfg.enable {
    home.file.".local/share/pandoc".source = config.util.link "/dotfiles/pandoc";
  };
}
