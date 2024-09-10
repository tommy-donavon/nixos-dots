local g = vim.g
local opt = vim.opt
local api = vim.api

g.mapleader = ' '
g.maplocalleader = ' '

opt.number = true
opt.mouse = 'a'
opt.showmode = true
opt.breakindent = true
opt.undofile = true
opt.showbreak = '+++'
opt.showmatch = true
opt.visualbell = true

opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

local indent = 4

opt.autoindent = true
opt.shiftwidth = indent
opt.tabstop = indent
opt.softtabstop = indent
opt.expandtab = true

opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

opt.ruler = true
opt.undolevels = 1000

opt.shell = os.getenv("SHELL") or 'zsh'

api.nvim_create_autocmd('FileType', {
	pattern = 'make',
	command = 'set noexpandtab',
})

api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
	pattern = '*.go',
	command = 'setlocal noet ts=4 sw=4 sts=4',
})

api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

api.nvim_create_autocmd('BufReadPost', {
	pattern = '*',
	callback = function()
		local line = vim.fn.line('\'"')
		if line >= 1 and line <= vim.fn.line('$') then
			vim.cmd('normal! g`"')
		end
	end,
})

vim.cmd([[
	hi Pmenu ctermfg=white ctermbg=238
]])
