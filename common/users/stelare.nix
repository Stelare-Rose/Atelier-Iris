{ config, lib, pkgs, ctx, ... }:
let 
  # Unwrap ctx here
  root = ctx.root;
in
  {
  imports = [ (root + /modules/home) ];
  home = {
    username = "Stelare";
    homeDirectory = "/home/Stelare";
    stateVersion = "24.05";
  };
}
