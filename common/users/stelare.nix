{ ctx, config, ... }:
let 
  # Unwrap ctx here
  root = ctx.root;
in
  {
  imports = [ 
    (root + /modules/home)
    (root + /attachments/link.nix)
  ];

  programs.home-manager.enable = true;
  home.file.".manual".source = config.util.link "/dotfiles/manual";
  home = {
    username = "Stelare";
    homeDirectory = "/home/Stelare";
    stateVersion = "24.05";
  };
}
