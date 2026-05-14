-- 1. Setup Lazy.nvim (Plugin Manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- 2. Basic Options
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.clipboard = "unnamedplus"
-- 3. Plugins
require("lazy").setup({
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = false,
					styles = { comments = "italic" },
				},
				groups = {
					all = {
						-- Your Custom Styling
						Normal = { bg = "#000000" },
						Canvas = { bg = "#000000" },
						NvimTreeNormal = { bg = "#0a0a0a", fg = "#dfdfdf" },
						NvimTreeNormalNC = { bg = "#0a0a0a" },
						NvimTreeWinSeparator = { fg = "#3d3d3d", bg = "#000000" },
						StatusLine = { bg = "#1a1a1a" },
						NormalFloat = { bg = "#1a1a1a" },
					},
				},
			})
			vim.cmd("colorscheme carbonfox")
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",

		build = ":TSUpdate",

		event = { "BufReadPost", "BufNewFile" },

		config = function()
			local ok, configs = pcall(require, "nvim-treesitter.configs")

			if not ok then
				return
			end

			configs.setup({
				ensure_installed = {
					"lua",
					"python",
					"bash",
				},

				auto_install = false,

				highlight = {
					enable = true,
				},
			})
		end,
	},

	-- THE 2026 Standard: Conform.nvim for Auto-formatting
	-- This fixes your "auto-format not working" issue reliably
	{
		"stevearc/conform.nvim",

		event = { "BufReadPre", "BufNewFile" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				python = { "isort", "black" },
				lua = { "stylua" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},

	-- File Explorer & UI
	{ "nvim-tree/nvim-tree.lua", opts = {} },
	{ "folke/which-key.nvim", opts = {} },

	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			require("fzf-lua").setup({
				winopts = {
					preview = {
						hidden = true, -- HUGE perf win on Pi
					},
				},
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	-- LSP Support
	{
		"neovim/nvim-lspconfig",

		config = function()
			vim.lsp.enable("jedi_language_server")
		end,
	},
	{
	  "ojroques/nvim-osc52",

		  config = function()
		    local osc52 = require("osc52")

		    osc52.setup({
		      max_length = 0,
		      silent = false,
		      trim = false,
		    })

		    vim.g.clipboard = {
		      name = "osc52",

		      copy = {
			["+"] = function(lines, _)
			  osc52.copy(table.concat(lines, "\n"))
			end,

			["*"] = function(lines, _)
			  osc52.copy(table.concat(lines, "\n"))
			end,
		      },

		      paste = {
			["+"] = function()
			  return {}
			end,

			["*"] = function()
			  return {}
			end,
		      },
		    }
		  end,
		},

		-- Inside your require("lazy").setup({ ... })
	{
	    "kdheepak/lazygit.nvim",
	    cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	    },
	    -- optional for floating window border decoration
	    dependencies = {
		"nvim-lua/plenary.nvim",
	    },
	    -- [WARN]: Ensure lazygit is installed on your OS (e.g., brew install lazygit)
	    -- [ERR]: If 'lazygit' is not in $PATH, this plugin will fail to launch.
	},

})

-- 4. Keymaps (Restored all your custom mappings)
local map = vim.keymap.set

-- File Operations
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Buffer Management
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Split Windows
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split Window Vertically" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Split Window Horizontally" })

-- File Explorer
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Explorer (NvimTree)" })
map("n", "<leader>fe", "<cmd>NvimTreeFocus<cr>", { desc = "Focus Explorer" })

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Save with Ctrl + S
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
map("i", "<C-s>", "<esc><cmd>w<cr>a", { desc = "Save File" })

-- Indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- JK to exit insert mode
map("i", "jk", "<Esc>")

local fzf = require("fzf-lua")

map("n", "<leader><space>", fzf.files, { desc = "Find Files" })
map("n", "<leader>ff", fzf.files, { desc = "Find Files" })
map("n", "<leader>/", fzf.live_grep, { desc = "Grep" })
map("n", "<leader>fg", fzf.live_grep, { desc = "Live Grep" })
map("n", "<leader>,", fzf.buffers, { desc = "Buffers" })
map("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
map("n", "<leader>fr", fzf.oldfiles, { desc = "Recent Files" })
map("n", "<leader>gf", fzf.git_files, { desc = "Git Files" })
map("n", "gr", fzf.lsp_references, { desc = "References" })
map("n", "gd", fzf.lsp_definitions, { desc = "Definitions" })
map("n", "<leader>ss", fzf.lsp_document_symbols, { desc = "Document Symbols" })
map("n", "<leader>sS", fzf.lsp_workspace_symbols, { desc = "Workspace Symbols" })
-- LazyGit
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Diagnostics
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "●",
    source = "if_many",
  },

  float = {
    border = "rounded",
  },

  signs = true,
  update_in_insert = false,
  underline = true,
})

-- LSP Keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local map = vim.keymap.set

    map("n", "gD", vim.lsp.buf.declaration, {
      buffer = ev.buf,
      desc = "Goto Declaration",
    })

    map("n", "gI", vim.lsp.buf.implementation, {
      buffer = ev.buf,
      desc = "Goto Implementation",
    })

    map("n", "K", vim.lsp.buf.hover, {
      buffer = ev.buf,
      desc = "Hover",
    })

    map("n", "<leader>cr", vim.lsp.buf.rename, {
      buffer = ev.buf,
      desc = "Rename",
    })

    map("n", "<leader>ca", vim.lsp.buf.code_action, {
      buffer = ev.buf,
      desc = "Code Action",
    })
  end,
})
