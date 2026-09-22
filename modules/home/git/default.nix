{ config, nixcfg, lib, ctx, ... }:
let
  cfg = config.home.git;
  root = ctx.root;
in {
  options.home.git.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.development.utilities.enable;
    description = "Enables git's home-manager config";
  };
  options.home.git.additionalConfig = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Lets git include additional config at ~/.config/git/additional";
  };
  options.home.git.copyStore = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Attempts to copy git credentials store";
  };
  config = lib.mkMerge [ 
    (lib.mkIf cfg.copyStore {
      sops.secrets."git/credentials" = {
        sopsFile = root + /secrets/common/git/credentials;
        format = "binary";
      };
      home.file.".config/git/credentials".source = config.util.link config.sops.secrets."git/credentials".path;
    })
    (lib.mkIf cfg.enable {
      programs.git = {
        enable = true;
        lfs.enable = true;
        settings = {
          credential.helper = "store";
          init.defaultBranch = "main";
          pull.rebase = true;
          push.autoSetupRemote = true;
          include.path = lib.mkIf cfg.additionalConfig "~/.config/git/additional";
        };
      };
    })
  ];
}
