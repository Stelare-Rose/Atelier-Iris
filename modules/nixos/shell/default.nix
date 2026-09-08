{config, lib, pkgs, ...}:
let
  cfg = config.modules.shell;
in 
  {
  options.modules.shell.enable = lib.mkEnableOption "Enables the fish shell, starship, zoxide, and commonly used shell programs";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fastfetch
      ripgrep
      eza
    ];
    programs.fish.enable = true;
    programs.starship.enable = true;
    programs.zoxide.enable = true;
  };
}
