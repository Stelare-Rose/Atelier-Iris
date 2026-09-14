{ config, lib, ... }:
{
  options.util.link = lib.mkOption {
    type = lib.types.functionTo lib.types.path;
    internal = true;
  };
  config.util.link = path:
    config.lib.file.mkOutOfStoreSymlink path;
}
