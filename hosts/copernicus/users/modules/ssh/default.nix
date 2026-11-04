{ config, ctx, ... }:
let
  root = ctx.root;
in {
  sops.secrets = {
    "Main" = {
      sopsFile = root + /secrets/copernicus/ssh/Main;
      format = "binary";
      path = "${config.home.homeDirectory}/.ssh/Main";
    };
  };
  home.file = {
    ".ssh/Main.pub".source = ./dotfiles/ssh/Main.pub;
    ".ssh/config".source = ./dotfiles/ssh/config;
  };
}
