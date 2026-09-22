{ config, ctx, ... }:
let 
  root = ctx.root;
  in
{
  sops.secrets = {
    "git/config" = {
      sopsFile = root + /secrets/crescent/git/config;
      format = "binary";
    };
    "git/stelare-config" = {
      sopsFile = root + /secrets/crescent/git/stelare-config;
      format = "binary";
    };
    "git/public-config" = {
      sopsFile = root + /secrets/crescent/git/public-config;
      format = "binary";
    };
    "Stelare-GitHub" = {
      sopsFile = root + /secrets/crescent/ssh/Stelare-GitHub;
      format = "binary";
      path = "/home/Stelare/.ssh/Stelare-GitHub";
    };
    "Public-GitHub" = {
      sopsFile = root + /secrets/crescent/ssh/Public-GitHub;
      format = "binary";
      path = "/home/Stelare/.ssh/Public-GitHub";
    };
  }; 
  home.file = {
    ".ssh/Stelare-GitHub.pub".source = config.util.link ./dotfiles/ssh/Stelare-GitHub.pub;
    ".ssh/Public-GitHub.pub".source = config.util.link ./dotfiles/ssh/Public-GitHub.pub;
    ".ssh/config".source = config.util.link ./dotfiles/ssh/config;
  };
  xdg.configFile = {
    "git/additional".source = config.util.link config.sops.secrets."git/config".path;
    "git/stelare-config".source = config.util.link config.sops.secrets."git/stelare-config".path;
    "git/public-config".source = config.util.link config.sops.secrets."git/public-config".path;
  };
}
