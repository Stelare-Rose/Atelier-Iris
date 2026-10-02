{ config, nixcfg, lib, ctx, pkgs, ... }:
let
  cfg = config.home.tmux;
  root = ctx.root;
in
  {
  options.home.tmux.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.shell.enable;
    description = "Enables tmux";
  };
  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      mouse = true;
      shell = "${pkgs.fish}/bin/fish";
      prefix = "`";
      plugins = [
        pkgs.tmuxPlugins.cpu
        pkgs.tmuxPlugins.battery
      ];
      extraConfig = builtins.readFile (root + /dotfiles/tmux/extraConfig.conf);
    };
  };
}
