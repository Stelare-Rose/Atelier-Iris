vim.opt.shell = "sh"

local latte = require("catppuccin.palettes").get_palette "latte"

require("nvim-treesitter").setup()
require("nvim-treesitter").install({
	indent = {
		enable = true;
		disable = { "dart" };
	},
  highlight = { enable = true }
})
vim.api.nvim_create_autocmd("FileType", {
  callback = function(event)
    if event.match == "dart" or event.match == "qml" then return end

    local ok = pcall(vim.treesitter.start)
    if not ok then return end

    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})

local milktea = require("milktea.palette");
require('lualine').setup {
	options = {
    theme = require("milktea.lualine"),
		icons_enabled = true,
		globalstatus = true,
		refresh = {
			statusline = 300,
		},
	},
	sections = {
		lualine_a = {
			{
				'mode', 
				separator = {right=''}
			}
		}, 
		lualine_b = {
			{
				'hostname', 
				separator = {right=''}
			}
		},
		lualine_c = {
			{
				require("noice").api.status.search.get,
				cond = require("noice").api.status.search.has,
				separator = {right=''}
			}
		},
		lualine_x = {
			{
				'branch', 
				'diff', 
				'diagnostics',
				separator = {left =''}

			}
		},
		lualine_y = {
			{
				'filetype',
				separator = {left =''}
			}
		},
		lualine_z = {
			{
				'filename',
				separator = {left ='', right=''}
			}
		}
	}
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
local cmp = require("cmp")
cmp.setup({
snippet = {
	-- REQUIRED - you must specify a snippet engine
	expand = function(args)
	-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
	require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
	-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
	-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
	-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
	end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		-- { name = 'vsnip' }, -- For vsnip users.
		{ name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
		}, {
			{ name = 'buffer' },
		})
		})
vim.keymap.set("n", "<leader>y", function()
	require("yazi").yazi()
end)

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})


local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

vim.lsp.config("html", {
	capabilities = capabilities,
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true
		},
		provideFormatter = true
	},
	opts = {
		settings = {
			html = {
				format = {
					templating = true,
					wrapLineLength = 120,
					wrapAttributes = 'auto',
			},
			css = {
				lint = {
					validProperties = {},
				},
			},
			hover = {
				documentation = true,
				references = true,
				},
			},
		},
	}
})
local base_on_attach = vim.lsp.config.eslint.on_attach
vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    if not base_on_attach then return end

    base_on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "LspEslintFixAll",
    })
  end,
}
)vim.lsp.config("ts_ls", {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        languages = {"javascript", "typescript", "vue"},
      },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
})
vim.diagnostic.config({ virtual_text = false, virtual_lines = { current_line = true }, })
require("flutter-tools").setup{}
vim.lsp.config("clangd", {
	cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
	nit_options = {
		fallbackFlags = { "-std=c++17" },
	},
})
vim.lsp.opts = {
	servers = {
		clangd = {
			mason = false,
		},
	},
}
vim.lsp.config("vue_ls", {})
vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', '.git' },
  settings = {
    ['rust-analyzer'] = {
      cargo = { allFeatures = true },
    },
  },
})
vim.lsp.config('qmlls', {
  cmd = { 'qmlls -E' },
  filetypes = { 'qml' },
  root_markers = { 'flake.nix', '.git' },
})
vim.lsp.config('astro', {
  cmd_env = { NODE_PATH = vim.fn.getcwd() .. "/node_modules" },
  init_options = {
    typescript = { tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib" },
  },
})

vim.lsp.enable('qmlls')
vim.lsp.enable("emmet_language_server")
vim.lsp.enable("csharp_ls")
vim.lsp.enable("eslint")
vim.lsp.enable("ts_ls")
vim.lsp.enable("html")
vim.lsp.enable("nixd")
vim.lsp.enable("pylsp")
vim.lsp.enable("clangd")
vim.lsp.enable("vue_ls")
vim.lsp.enable('gopls')
vim.lsp.enable('jdtls')
vim.lsp.enable('dartls')
vim.lsp.enable('svelte')
vim.lsp.enable('rust_analyzer')

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = false

vim.wo.relativenumber = true
vim.wo.number = true
vim.cmd.colorscheme("milktea")

-- Bye bye arrow keys
local modes = { 'n', 'i', 'v', 'x', 'o' }
local function nope()
	vim.notify("Nope", vim.log.levels.INFO)
end
vim.keymap.set(modes, '<Up>', nope)
vim.keymap.set(modes, '<Down>', nope)
vim.keymap.set(modes, '<Left>', nope)
vim.keymap.set(modes, '<Right>', nope)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.dart",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.g.vimtex_view_method = 'zathura'
