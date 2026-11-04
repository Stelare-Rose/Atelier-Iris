{ pkgs, ... }:
{
  services.matrix-continuwuity = {
    enable = true;
    package = pkgs.matrix-continuwuity_latest;
    settings.global = {
      server_name = "matrix.starrytea.cc";
      address = [ "127.0.0.1" ];
      port = [ 6167 ];
      allow_registration = false;
      new_user_displayname_suffix = "";
      well_known = {
        client = "https://matrix.starrytea.cc";
        server = "matrix.starrytea.cc:443";
      };
    };
  };
}
