{ config, nixcfg, lib, ... }:
let
  cfg = config.home.fish;
in {
  options.home.fish.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.shell.enable;
    description = "Enables fish's home-manager side";
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."fish".source = config.util.link "/dotfiles/fish";
    home.file.".scripts".source = config.util.link "/dotfiles/scripts";
  };
}
