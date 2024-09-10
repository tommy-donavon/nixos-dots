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
				["n"] = {
					-- your custom normal mode mappings
				},
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
