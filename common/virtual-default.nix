{ lib, ... }: 
{
  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = lib.mkDefault 2048;
        cores = lib.mkDefault 4;
      };         
    };
    vmVariantWithBootLoader = {
      virtualisation = {
        memorySize = lib.mkDefault 2048;
        cores = lib.mkDefault 4;
      };
    };
  };
}
