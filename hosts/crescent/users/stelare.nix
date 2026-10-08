{ ... }:
{
  imports = [
    ./modules/git
    ./modules/ssh
  ];
  home.hyprland.monitor = {
    height = 1200;
  };
  sops.age.keyFile = "/home/Stelare/.config/sops/age/keys.txt";
}
