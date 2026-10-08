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
  }; 

  xdg.configFile = {
    "git/additional".source = config.sops.secrets."git/config".path;
    "git/stelare-config".source = config.sops.secrets."git/stelare-config".path;
    "git/public-config".source = config.sops.secrets."git/public-config".path;
  };
}
