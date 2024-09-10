local mason = require('mason')

mason.setup({
	ui = {
		keymaps = {
			toggle_package_expand = '<CR>',
			install_package = 'i',
			update_package = 'u',
			check_package_version = 'c',
			update_all_packages = 'U',
			check_outdated_packages = 'C',
			uninstall_package = 'X',
			cancel_installation = '<C-c>',
			apply_language_filter = '/',
		},
	},
})


require('mason-null-ls').setup({
	ensure_installed = nil,
	automatic_installation = false,
	automatic_setup = true,
})
require('null-ls').setup()
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig')
local lspconfig_configs = require('lspconfig.configs')
if not lspconfig_configs.ls_emmet then
	lspconfig_configs.ls_emmet = {
		default_config = {
			cmd = { 'ls_emmet', '--stdio' },
			filetypes = {
				'html',
				'css',
				'scss',
				'javascript',
				'javascriptreact',
				'typescript',
				'typescriptreact',
				'haml',
				'xml',
				'xsl',
				'pug',
				'slim',
				'sass',
				'stylus',
				'less',
				'sss',
				'hbs',
				'handlebars',
			},
			---@diagnostic disable-next-line: unused-local
			root_dir = function(fname)
				return vim.loop.cwd()
			end,
			settings = {},
		},
	}
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local default_opt = {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	},
}

local util = require('lspconfig.util')

local servers = {
	tsserver = {
		root_dir = lspconfig.util.root_pattern('tsconfig.json', 'package.json', '.git'),
	},
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
					special = { reload = 'require' },
				},
				workspace = {
					library = {
						vim.fn.expand('$VIMRUNTIME/lua'),
						vim.fn.expand('$VIMRUNTIME/lua/vim/lsp'),
						vim.fn.stdpath('data') .. '/lazy/lazy.nvim/lua/lazy',
						'${3rd}/luv/library',
					},
				},
			},
		},
	},
}

local install_root_dir = vim.fn.stdpath('data') .. '/mason'

require('mason-lspconfig').setup_handlers({
	function(server_name) -- default handler (optional)
		local opt = servers[server_name] or {}
		opt = vim.tbl_deep_extend('force', {}, default_opt, opt)
		lspconfig[server_name].setup(opt)
	end,
})
