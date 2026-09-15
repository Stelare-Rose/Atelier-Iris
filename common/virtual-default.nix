{ lib, ... }: 
{
  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = lib.mkDefault 2048;
        cores = lib.mkDefault 4;
        diskSize = lib.mkDefault 32768;
      };         
    };
    vmVariantWithBootLoader = {
      virtualisation = {
        memorySize = lib.mkDefault 2048;
        cores = lib.mkDefault 4;
        diskSize = lib.mkDefault 32768;
      };
    };
  };
}
