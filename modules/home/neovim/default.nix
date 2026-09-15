{ config, nixcfg, lib, ctx, pkgs, ... }:
let
  cfg = config.home.neovim;
  root = ctx.root;
in {
  options.home.neovim.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.shell.enable;
    description = "Enables neovim";
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."nvim/lua".source = config.util.link (root + /dotfiles/nvim/lua);
    xdg.configFile."nvim/colors".source = config.util.link (root + /dotfiles/nvim/colors);
    home.packages = with pkgs; [	
      nixd
    ];
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      initLua = "require(\"config\")";
      plugins = with pkgs.vimPlugins; [
        catppuccin-nvim
        nvim-treesitter.withAllGrammars
        telescope-nvim
        lualine-nvim
        nvim-lspconfig
        luasnip
        nvim-cmp
        cmp_luasnip
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        yazi-nvim
        noice-nvim
        lazygit-nvim
        harpoon2
        nvim-jdtls
        flutter-tools-nvim
        vimtex
        coc-vimtex
        cmp-vimtex
      ];
    };
  };
}
