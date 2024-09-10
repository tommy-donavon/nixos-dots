local telescope = require("telescope")

local fb_actions = require("telescope").extensions.file_browser.actions

local previewers = require("telescope.previewers")

local new_maker = function(filepath, bufnr, opts)
	opts = opts or {}

	filepath = vim.fn.expand(filepath)
	vim.loop.fs_stat(filepath, function(_, stat)
		if not stat then
			return
		end
		if stat.size > 100000 then
			return
		else
			previewers.buffer_previewer_maker(filepath, bufnr, opts)
		end
	end)
end

local theme = "ivy"

telescope.setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		mappings = {
			i = {
				["<C-a>"] = { "<esc>0i", type = "command" },
				["<Esc>"] = require("telescope.actions").close,
			},
		},
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "smart" },
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		buffer_previewer_maker = new_maker,
	},
	extensions = {
		["ui-select"] = {
			-- TODO: specify the cursor theme for codeaction only
			require("telescope.themes").get_cursor({}),
		},
		file_browser = {
			theme = theme,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
					["<C-h>"] = fb_actions.goto_parent_dir,
					["<C-e>"] = fb_actions.rename,
					["<C-c>"] = fb_actions.create,
				},
				-- ['n'] = {
				-- 	-- your custom normal mode mappings
				-- },
			},
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
		media_files = {
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg", -- find command (defaults to `fd`)
		},
	},
	pickers = {
		buffers = {
			theme = theme,
		},
		find_files = {
			theme = theme,
			hidden = true,
		},
		oldfiles = {
			theme = theme,
			hidden = true,
		},
		live_grep = {
			debounce = 100,
			theme = theme,
			on_input_filter_cb = function(prompt)
				-- AND operator for live_grep like how fzf handles spaces with wildcards in rg
				return { prompt = prompt:gsub("%s", ".*") }
			end,
		},
		current_buffer_fuzzy_find = {
			theme = theme,
		},
		commands = {
			theme = theme,
		},
		lsp_document_symbols = {
			theme = theme,
		},
		diagnostics = {
			theme = theme,
			initial_mode = "normal",
		},
		lsp_references = {
			theme = "cursor",
			initial_mode = "normal",
			layout_config = {
				width = 0.8,
				height = 0.4,
			},
		},
		lsp_code_actions = {
			theme = "cursor",
			initial_mode = "normal",
		},
	},
})

telescope.load_extension("projects")
telescope.load_extension("file_browser")

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
