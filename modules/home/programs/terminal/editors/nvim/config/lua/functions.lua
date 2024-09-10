local M = {}

function M.find_current_directory_files()
	local dir = vim.fn.expand('%:p:h')
	if dir == '' then
		dir = vim.fn.getcwd()
	end
	local opts = require('telescope.themes').get_ivy({})
	opts = vim.tbl_extend('force', opts, {
		path = dir,
		prompt_title = 'Files in ' .. dir,
	})
	require('telescope').extensions.file_browser.file_browser(opts)
end

return M
