{ ... }:
{
  services.firefly-iii = {
    enable = true;
    enableNginx = true;
    virtualHost = "firefly.starrytea.cc";
    settings = {
      APP_ENV = "production";
      APP_URL = "https://firefly.starrytea.cc";
      APP_KEY_FILE = "/var/lib/secrets/firefly-app-key";
      TRUSTED_PROXIES = "**";
      DB_CONNECTION = "sqlite";
      SITE_OWNER = "Stelare@starrytea.cc";
      TZ = "Asia/Jakarta";
    };
  };
}
