{ config, ctx, ... }:
let 
  root = ctx.root;
  in
{
  sops.secrets = {
    "git/config" = {
      sopsFile = root + /secrets/selene/git/config;
      format = "binary";
    };
    "git/stelare-config" = {
      sopsFile = root + /secrets/selene/git/stelare-config;
      format = "binary";
    };
    "git/public-config" = {
      sopsFile = root + /secrets/selene/git/public-config;
      format = "binary";
    };
    "Stelare-GitHub" = {
      sopsFile = root + /secrets/selene/ssh/Stelare-GitHub;
      format = "binary";
      path = "/home/Stelare/.ssh/Stelare-GitHub";
    };
    "Public-GitHub" = {
      sopsFile = root + /secrets/selene/ssh/Public-GitHub;
      format = "binary";
      path = "/home/Stelare/.ssh/Public-GitHub";
    };
  }; 
  home.file = {
    ".ssh/Stelare-GitHub.pub".source = ./dotfiles/ssh/Stelare-GitHub.pub;
    ".ssh/Public-GitHub.pub".source = ./dotfiles/ssh/Public-GitHub.pub;
    ".ssh/config".source = ./dotfiles/ssh/config;
  };
  xdg.configFile = {
    "git/additional".source = config.sops.secrets."git/config".path;
    "git/stelare-config".source = config.sops.secrets."git/stelare-config".path;
    "git/public-config".source = config.sops.secrets."git/public-config".path;
  };
}
