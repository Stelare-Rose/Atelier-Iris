{ config, lib, ... }:
{
  options.iris.repoPath = lib.mkOption {
    type = lib.types.str;
    default = "${config.home.homeDirectory}/Atelier-Iris";
    description = "Provides Repo Path for symlinking";
  };
}
