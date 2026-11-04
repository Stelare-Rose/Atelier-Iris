{ config, pkgs, unstable, ctx, ... }:
let
  root = ctx.root;
in
{
  sops.secrets."forgejo-runner-token" = {
    sopsFile = root + "/secrets/copernicus/forgejo/token";
    format = "binary";
  };
  services.gitea-actions-runner = {
    package = unstable.forgejo-runner;
    instances.default = {
      name = "Copernicus";
      enable = true;
      url = "http://localhost:3000";
      labels = [ "native:host" ];
      token = "";
      tokenFile = config.sops.secrets."forgejo-runner-token".path;
      hostPackages = with pkgs; [ nix git bash coreutils openssh nodejs ];
      settings = {
        runner.labels = [ "native:host" ];
        server.connections.forgejo = {
          url = "http://localhost:3000";
          uuid = "783b18dd-883f-458d-a263-8d28fbe4ff67";
        };
      };
    };
  };
}
