{ config, pkgs, ctx, ... }:
let
  root = ctx.root;
  cfgPath = config.sops.templates."forgejo-runner.yml".path;
  unstable = ctx.unstable;
in
{
  sops.secrets."forgejo-runner-token" = {
    sopsFile = root + "/secrets/copernicus/forgejo/token";
    format = "binary";
  };
  sops.templates."forgejo-runner.yml".content = ''
    runner:
      labels:
        - "native:host"
    server:
      connections:
        forgejo:
          url: http://localhost:3000
          uuid: 783b18dd-883f-458d-a263-8d28fbe4ff67
          token: ${config.sops.placeholder."forgejo-runner-token"}
  '';

  systemd.services.forgejo-runner = {
    description = "Forgejo Actions Runner";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    path = with pkgs; [ nix git bash coreutils openssh nodejs ];
    environment.HOME = "/var/lib/forgejo-runner";
    serviceConfig = {
      ExecStart = "${unstable.forgejo-runner}/bin/forgejo-runner daemon --config %d/config.yml";
      LoadCredential = "config.yml:${cfgPath}";
      DynamicUser = true;
      StateDirectory = "forgejo-runner";
      WorkingDirectory = "/var/lib/forgejo-runner";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
