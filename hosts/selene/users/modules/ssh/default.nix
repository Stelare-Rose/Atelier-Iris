{ ctx, ... }:
let
  root = ctx.root;
in {
  sops.secrets = {
    "Stelare-GitHub" = {
      sopsFile = root + /secrets/selene/ssh/Stelare-GitHub;
      format = "binary";
      path = "/home/Stelare/.ssh/Stelare-GitHub";
    };
    "Public-GitHub" = {
      sopsFile = root + /secrets/selene/ssh/Public-GitHub;
      format = "binary";
      path = "/home/Stelare/.ssh/Public-GitHub";
    };
    "Main" = {
      sopsFile = root + /secrets/selene/ssh/Main;
      format = "binary";
      path = "/home/Stelare/.ssh/Main";
    };
  };
  home.file = {
    ".ssh/Stelare-GitHub.pub".source = ./dotfiles/ssh/Stelare-GitHub.pub;
    ".ssh/Public-GitHub.pub".source = ./dotfiles/ssh/Public-GitHub.pub;
    ".ssh/Main.pub".source = ./dotfiles/ssh/Main.pub;
    ".ssh/config".source = ./dotfiles/ssh/config;
  };
}
