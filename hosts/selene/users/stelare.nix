{ ... }:
{
  imports = [
    ./modules/git
  ];
  home.hyprland.monitor = {
    refresh = 165;
  };
  home.whisper.enable = true;
  sops.age.keyFile = "/home/Stelare/.config/sops/age/keys.txt";
}
