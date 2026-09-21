{ config, nixcfg, lib, pkgs, ... }:
let
  cfg = config.home.pyxis;
in
  {
  options.home.pyxis.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.constellation.enable;
    description = "Enables Pyxis Service (Currently Impure)";
  };
  config = lib.mkIf cfg.enable {
    systemd.user.services.pyxis = {
      Unit = {
        Description = "Background Indexing and Notification service for Pyxis";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "${pkgs.writeShellScript "watch-store" ''
            #!/run/current-system/sw/bin/fish
            cd /home/Stelare/Sync/Programming/Git/Pyxis-Service/bin
            ./Pyxis-Service
            ''}";
      };
    };
  };
}

