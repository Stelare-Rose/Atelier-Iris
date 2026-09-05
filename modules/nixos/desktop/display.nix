{ config, lib, pkgs, ... }: 
{
  config = lib.mkIf config.modules.desktop.enable {
    services.xserver.enable = true;
    environment.systemPackages = with pkgs; [ 
      nunito
      (catppuccin-sddm.override {
        flavor = "latte";
        accent = "lavender";
        font = "Nunito";
        fontSize = "9";
        background = ./sddm/wallpaper.png;
        loginBackground = true;
      })
    ];

    services.displayManager.sddm = {
      enable = true;
      theme = "catppuccin-latte-lavender";
    };
  };
}
