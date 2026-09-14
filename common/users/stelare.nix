{ config, lib, pkgs, ctx, ... }:
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
  home = {
    username = "Stelare";
    homeDirectory = "/home/Stelare";
    stateVersion = "24.05";
  };
}
