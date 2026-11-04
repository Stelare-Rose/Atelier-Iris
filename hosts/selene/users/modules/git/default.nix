{ config, ctx, ... }:
let
  root = ctx.root;
in
{
  sops.secrets = {
    "git/config" = {
      sopsFile = root + /secrets/selene/git/config;
      format = "binary";
      path = "${config.xdg.configHome}/git/additional";
    };
    "git/stelare-config" = {
      sopsFile = root + /secrets/selene/git/stelare-config;
      format = "binary";
      path = "${config.xdg.configHome}/git/stelare-config";
    };
    "git/public-config" = {
      sopsFile = root + /secrets/selene/git/public-config;
      format = "binary";
      path = "${config.xdg.configHome}/git/public-config";
    };
  };
}
