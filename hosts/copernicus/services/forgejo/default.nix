{ ... }:
{
  imports = [ ./runner.nix ];
  services.forgejo = {
    enable = true;
    database.type = "sqlite3";
    settings = {
      server = {
        DISABLE_SSH = true;
        DOMAIN = "git.starrytea.cc";
        ROOT_URL = "https://git.starrytea.cc";
        HTTP_PORT = 3000;
      };
      service.DISABLE_REGISTRATION = true;
      ui = {
        THEMES = "forgejo-auto,forgejo-light,forgejo-dark,milktea";
        DEFAULT_THEME = "milktea";
      };
    };
  };
}
