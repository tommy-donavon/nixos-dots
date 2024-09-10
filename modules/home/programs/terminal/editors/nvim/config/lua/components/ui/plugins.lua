local driver = require('driver')

driver.add_plugin('nvimdev/dashboard-nvim', {
	event = 'VimEnter',
	config = function()
		require('components.ui.configs.dashboard')
	end
})

driver.add_plugin('rose-pine/neovim', {
	config = function()
		require('components.ui.configs.themes.rose-pine-moon')
	end
})
