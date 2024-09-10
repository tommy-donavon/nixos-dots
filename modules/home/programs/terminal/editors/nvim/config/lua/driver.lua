local M = {}
local plugins = {}
local plugins_seen = {}

local utils = require('utils')

function M.add_plugin(name, opts)
	if plugins_seen[name] then
		print(string.format('[Warning] Plugin %s already added!', name))
		return
	end
	plugins[#plugins + 1] = vim.tbl_extend('force', { name }, opts or {})
	plugins_seen[name] = true
end

local function load_component_plugins()
	for _, m in ipairs(utils.find_modules(utils.script_path(), 'plugins.lua')) do
		-- current_layer_name = m.layer_name
		require(m .. ".plugins")
		-- current_layer_name = nil
	end
end

local function setup_plugins()
	load_component_plugins()
	local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
	if not vim.loop.fs_stat(lazypath) then
		print('installing lazy.nvim...')
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'--depth=1',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable', -- latest stable release
			lazypath,
		})
		print('installing lazy.nvim...done')
	end
	vim.opt.rtp:prepend(lazypath)

	plugins = vim.tbl_extend('force', {
		{
			'lewis6991/impatient.nvim',
		},

		{ 'nvim-lua/plenary.nvim', lazy = true },

		{
			'antoinemadec/FixCursorHold.nvim', -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
			event = 'VimEnter',
		},
		{
			'rcarriga/nvim-notify',
			config = function()
				require('notify').setup({
					stages = 'fade_in_slide_out',

					on_open = nil,

					on_close = nil,

					render = 'default',

					timeout = 5000,

					background_colour = 'Normal',

					minimum_width = 50,

					icons = {
						ERROR = '',
						WARN = '',
						INFO = '',
						DEBUG = '',
						TRACE = '✎',
					},
				})
			end,
			event = 'BufRead',
		},
	}, plugins)

	local snapshot_path = vim.fn.stdpath('config') .. '/packer-snapshots/cosmos.json'
	local snapshot_file = io.open(snapshot_path, 'r')
	if snapshot_file ~= nil then
		local snapshot_json_string = snapshot_file:read('*all')
		snapshot_file:close()
		local snapshot = vim.fn.json_decode(snapshot_json_string)

		for _, opts in ipairs(plugins) do
			if os.getenv('NVIM_BUILD_IMG') ~= nil then
				opts.event = nil
			end
			if snapshot ~= nil then
				local plugin_name = opts[1]
				for plugin_name_, plugin_commit in pairs(snapshot) do
					-- if plugin_name endswith plugin_name_
					if plugin_name:sub(- #plugin_name_) == plugin_name_ then
						opts.commit = plugin_commit['commit']
						break
					end
				end
			end
		end
	end

	require('lazy').setup(plugins)
end

function M.startup()
	require('settings')
	-- require('keymappings')
	setup_plugins()
	require('theme')
end

return M
