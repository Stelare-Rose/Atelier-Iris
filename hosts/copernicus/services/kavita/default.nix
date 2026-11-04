{ config, ctx, ... }:
let
  root = ctx.root;
  in
{
  sops.secrets."kavita-token" = {
    sopsFile = root + "/secrets/copernicus/kavita/token";
    format = "binary";
  };
  services.kavita = {
    enable = true;
    dataDir = "/home/shared/kavita";
    tokenKeyFile = config.sops.secrets."kavita-token".path;
  };
}
