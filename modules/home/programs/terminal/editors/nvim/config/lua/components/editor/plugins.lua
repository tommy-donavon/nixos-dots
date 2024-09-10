local driver = require("driver")

driver.add_plugin("ahmedkhalf/project.nvim", {
	config = function()
		require("components.editor.configs.project")
	end,
})

driver.add_plugin("nvim-telescope/telescope.nvim", {
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",

			build = "make",

			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
	},

	config = function()
		require("components.editor.configs.telescope")
	end,
})

driver.add_plugin("nvim-telescope/telescope-file-browser.nvim", {
	dependencies = { "nvim-telescope/telescope.nvim" },
})

driver.add_plugin("Bilal2453/luvit-meta", { lazy = true })

driver.add_plugin("williamboman/mason.nvim", {
	dependencies = {
		{ "williamboman/mason-lspconfig.nvim", lazy = true },
		{ "neovim/nvim-lspconfig", lazy = true },
		{ "hrsh7th/cmp-nvim-lsp", lazy = true, dependencies = { "hrsh7th/nvim-cmp" } },
		-- { 'folke/neodev.nvim', lazy = true },
		{ "nvimtools/none-ls.nvim", lazy = true, event = { "BufReadPost", "BufNewFile" } },
		{ "jay-babu/mason-null-ls.nvim", lazy = true },
		{ "simrat39/inlay-hints.nvim", lazy = true },
		{ "simrat39/rust-tools.nvim", lazy = true },
	},
	config = function()
		require("components.editor.configs.mason")
	end,
})

driver.add_plugin("hrsh7th/nvim-cmp", {
	event = "InsertEnter",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		{
			"windwp/nvim-autopairs",
			branch = "master",
			config = function()
				local autopairs = require("nvim-autopairs")
				autopairs.setup({
					disable_filetype = { "TelescopePrompt", "vim" },
				})
			end,
			lazy = true,
		},
	},
	config = function()
		require("components.editor.configs.cmp")
	end,
})

driver.add_plugin("hrsh7th/cmp-nvim-lua", { dependencies = { "hrsh7th/nvim-cmp" }, event = "BufRead" })
driver.add_plugin("hrsh7th/cmp-buffer", { dependencies = { "hrsh7th/nvim-cmp" }, event = "BufRead" })
driver.add_plugin("hrsh7th/cmp-path", { dependencies = { "hrsh7th/nvim-cmp" }, event = "BufRead" })
driver.add_plugin("hrsh7th/cmp-cmdline", { dependencies = { "hrsh7th/nvim-cmp" }, event = "BufRead" })
driver.add_plugin("dmitmel/cmp-cmdline-history", { dependencies = { "hrsh7th/nvim-cmp" }, event = "BufRead" })

driver.add_plugin("folke/which-key.nvim", {

	event = "VimEnter",
	opts = {
		icons = {
			mappings = true,
			keys = {},
		},
		spec = {
			{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
		},
	},
})

driver.add_plugin("nvim-treesitter/nvim-treesitter", {
	build = function()
		if #vim.api.nvim_list_uis() ~= 0 then
			vim.cmd("TSUpdate")
		end
	end,
	config = function()
		require("components.editor.configs.treesitter")
	end,
	event = { "BufRead", "BufNewFile" },
})
driver.add_plugin("nvim-treesitter/playground", {
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "BufRead",
})
driver.add_plugin("nvim-treesitter/nvim-treesitter-textobjects", {
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "BufRead",
})
driver.add_plugin("RRethy/nvim-treesitter-textsubjects", {
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "BufRead",
})

driver.add_plugin("JoosepAlviste/nvim-ts-context-commentstring", {
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "BufRead",
})

driver.add_plugin("windwp/nvim-ts-autotag", {
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "BufRead",
})

driver.add_plugin("stevearc/conform.nvim", {
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	branch = "nvim-0.9",
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 500,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			terraform = { "terraform_fmt" },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
		},
	},
})
