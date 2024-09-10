local project = require('project_nvim')
project.setup({
	exclude_dirs = { '*//*' },
	detection_methods = { 'pattern' },
	patterns = { '.git' },
})
