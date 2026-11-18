{ config, lib, ... }:
let
  cfg = config.home.links;
in {
  options.home.links.enable = lib.mkEnableOption "Symlinks for Obsidian and Git through Syncthing";
  config = lib.mkIf cfg.enable {
    home.file = lib.mapAttrs' (name: target: lib.nameValuePair "Links/${name}"
      { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Sync/${target}"; }
    ) {
        Atelier-Hydrangea = "Synced/@Obsidian/Atelier Hydrangea";
        Atelier-Alyssum = "Synced/@Obsidian/Atelier Alyssum";
        Active-Programming = "Programming/Active"; 
        Starry = "Programming/Git/Stelare-Starry"; 
        Public = "Programming/Git/Public-GitHub"; 
      };
  };
}
