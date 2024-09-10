local M = {}

function M.script_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)") or "."
end

function M.find_modules(baseDir, targetFile)
	baseDir = baseDir:gsub("/$", "") .. "/" -- Ensure baseDir ends with a slash

	local modules = {}
	local function scan_directory(dir)
		local handle = io.popen('find "' .. dir .. '" -type f -name "' .. targetFile .. '"')
		if not handle then
			error("Failed to execute find command")
		end
		for file in handle:lines() do
			local modulePath = file:sub(#baseDir + 1, -(#targetFile + 2)) -- Remove baseDir prefix and targetFile suffix
			local moduleName = modulePath:gsub("/", ".")
			table.insert(modules, moduleName)
		end

		handle:close()
	end

	scan_directory(baseDir)
	return modules
end

return M
