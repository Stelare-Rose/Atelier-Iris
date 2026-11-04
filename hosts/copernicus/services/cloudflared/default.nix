{ ... }:
let
  tunnel = name: host: port: {
    credentialsFile = "/etc/cloudflared/${name}.json";
    default = "http_status:404";
    ingress."${host}".service = "http://localhost:${toString port}";
  };
in
  {
  services.cloudflared = {
    enable = true;
    tunnels = {
      forgejo = tunnel "forgejo" "git.starrytea.cc" 3000;
      kavita  = tunnel "kavita" "books.starrytea.cc" 5000;
      immich  = tunnel "immich" "photos.starrytea.cc" 2283;
      firefly = tunnel "firefly" "firefly.starrytea.cc" 80;
      matrix  = tunnel "matrix" "matrix.starrytea.cc" 6167;
    };
  };
}
