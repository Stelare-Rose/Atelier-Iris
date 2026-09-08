{ config, lib, ctx, pkgs, ... }:
let 
  cfg = config.modules.gaming;
  unstable = ctx.unstable;
in
  {
  options.modules.gaming.enable = lib.mkEnableOption "gaming-related programs and settings";
  options.modules.gaming.dawn.enable = lib.mkEnableOption "dawn-winery proton";
  config = lib.mkMerge [
    (lib.mkIf cfg.dawn.enable {
      assertions = [{
        assertion = cfg.enable;
        message = "modules.gaming.dawn.enable requires modules.gaming.enable to be true";
      }];
    })
    (lib.mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        steamcmd
        umu-launcher
        prismlauncher
        gamemode
        parsec-bin
        wineWow64Packages.full
        faudio # Needed for Proton and Wine
        dxvk
        moonlight-qt
      ];
      programs.gamescope.enable = true;
      # TODO: Look into refactoring with nix-flatpak (github:gmodena/nix-flatpak)
      services.flatpak.enable = true; # Enabled for Sober
      programs.steam = {
        enable = true;
        extraCompatPackages = [
          unstable.proton-ge-bin
        ] ++ lib.optional cfg.dawn.enable unstable.dwproton-bin;
      };
    })
  ];
}
