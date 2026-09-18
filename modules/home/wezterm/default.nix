{ config, nixcfg, lib, ctx, ...}:
let
  cfg = config.home.wezterm;
  root = ctx.root; 
in
  {
  options.home.wezterm.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.desktop.enable;
    description = "Enables the home-manager side of wezterm";
  };
  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile (root + /dotfiles/wezterm/wezterm.lua);
    };
    home.sessionVariables.TERMCMD = "wezterm start --always-new-process";
  };
}
