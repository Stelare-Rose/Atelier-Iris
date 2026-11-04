{ ... }:
{
  services.rpcbind.enable = true;

  fileSystems."/export/Stelare" = {
    device = "/home/Stelare";
    options = [ "bind" ];
    fsType = "none";
  };
  fileSystems."/export/public" = {
    device = "/home/shared";
    options = [ "bind" ];
    fsType = "none";
  };

  services.nfs.server = {
    enable = true;
    exports = ''
      /export         *(rw,fsid=0,no_subtree_check)
      /export/Stelare *(insecure,rw,no_subtree_check,nohide,anonuid=1000)
      /export/public  *(insecure,rw,no_subtree_check,nohide,anonuid=1000)
    '';
  };
}
