local home = os.getenv("HOME")
local db = require("dashboard")
db.setup({
	theme = "doom",
	config = {
		-- footer = { utils.get_quote() },
		center = {
			{
				icon = "  ",
				desc = "List Projects",
				action = "Telescope projects",
				shortcut = "SPC p p",
			},
			{
				icon = "  ",
				desc = "Recent Files",
				-- action = 'Telescope old_files',
				action = "lua require('functions').find_current_directory_files()",
				shortcut = "SPC f f",
			},
			{
				icon = "  ",
				desc = "Find File",
				action = "Telescope find_files",
				shortcut = "SPC f f",
			},
			{
				icon = "󰊄  ",
				desc = "Find Text",
				action = "Telescope live_grep",
				shortcut = "SPC /  ",
			},
		},
	},
	preview = {
		command = "chafa --passthrough tmux -f symbols -s 60x60 -c full --fg-only --symbols braille --clear",
		-- file_path = '$(ls ' .. home .. '/.config/nvim/static/*.gif | sort -R)',
		file_path = home .. "/.config/nvim/static/dashboard.webp",
		file_height = 24,
		file_width = 64,
	},
})
