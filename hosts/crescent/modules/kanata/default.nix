{ ... }:
{
  services.kanata = {
    enable = true;
    keyboards = {
      laptop = {
        devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
        extraDefCfg = ''linux-dev-names-include ("AT Translated Set 2 keyboard") process-unmapped-keys yes'';
        config = builtins.readFile ./dotfiles/laptop.kbd;
      };
    };
  };
  hardware.uinput.enable = true;
  users.users.Stelare.extraGroups = [ "input" "uinput" ];
}
