{ ... }:
{
  imports = [
    ./modules/ssh
  ];
  sops.age.keyFile = "/home/Stelare/.config/sops/age/keys.txt";
}
