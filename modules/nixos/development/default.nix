{ config, lib, pkgs, ctx, ... }:
let 
  cfg = config.modules.development;
  unstable = ctx.unstable;
in
  {
  options.modules.development.enable = lib.mkEnableOption "all development options";
  options.modules.development.android.enable = lib.mkEnableOption "android development suite";
  options.modules.development.databases.enable = lib.mkEnableOption "database utility development suite";
  options.modules.development.utilities.enable = lib.mkEnableOption "various development utilities";
  options.modules.development.game.enable = lib.mkEnableOption "godot";
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      modules.development.android.enable = lib.mkDefault true;
      modules.development.databases.enable = lib.mkDefault true;
      modules.development.utilities.enable = lib.mkDefault true;
      modules.development.game.enable = lib.mkDefault true;
    })
    (lib.mkIf cfg.android.enable {
      nixpkgs.config.android_sdk.accept_license = true;
      environment.systemPackages = with pkgs; [
        android-tools
        temurin-bin-21
        (androidenv.emulateApp {
          name = "test-emulator-android";
          platformVersion = "33";
          abiVersion = "x86_64";
          systemImageType = "google_apis_playstore";
          avdHomeDir = "/home/Stelare/.avdHome";
          configOptions = {
            "fastboot.forceColdBoot"="yes";
            "hw.keyboard"="yes";
          };
        }) 
      ];
    })
    (lib.mkIf (cfg.android.enable && config.modules.user.enable) {
      users.users.Stelare.extraGroups = [ "adbusers" "kvm" ];
    })
    (lib.mkIf cfg.databases.enable {
      environment.systemPackages = with pkgs; [
        sqlcmd
        mysql84
        dbeaver-bin
      ];
      services.mysql = {
        enable = true;
        package = pkgs.mysql84;
      };
    })
    (lib.mkIf cfg.utilities.enable {
      environment.systemPackages = with pkgs; [
        unstable.opencode
        tokei
        jq
        cloudflared
        posting
      ];
    })
    (lib.mkIf cfg.game.enable {
      environment.systemPackages = with pkgs; [
        godot
        godot-mono
      ];
    })
  ];
}
