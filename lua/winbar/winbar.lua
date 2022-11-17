local M = {}

local opts = require("winbar.config").options
local f = require("winbar.utils")

local hl_winbar_path = "WinBarPath"
local hl_winbar_file = "WinBarFile"

local winbar_file = function()
	local file_path = vim.fn.expand("%:~:.:h")
	local filename = vim.fn.expand("%:t")
	local file_type = vim.fn.expand("%:e")
	local value = ""

	file_path = file_path:gsub("^%.", "")
	file_path = file_path:gsub("^%/", "")

	if not f.isempty(filename) then
		if f.isempty(file_type) then
			file_type = ""
		end

		value = " "
		if opts.show_file_path then
			local file_path_list = {}
			local _ = string.gsub(file_path, "[^/]+", function(w)
				table.insert(file_path_list, w)
			end)

			for i = 1, #file_path_list do
				value = value
					.. "%#"
					.. hl_winbar_path
					.. "#"
					.. file_path_list[i]
					.. " "
					.. opts.icons.seperator
					.. " %*"
			end
		end
		value = value .. "%#" .. hl_winbar_file .. "#" .. filename .. "%*"
	end

	return value
end

local excludes = function()
	if vim.tbl_contains(opts.exclude_filetype, vim.bo.filetype) then
		vim.opt_local.winbar = nil
		return true
	end

	return false
end

M.init = function()
	print(vim.inspect(f.isempty(opts.colors.path)))
	if f.isempty(opts.colors.path) then
		hl_winbar_path = "MsgArea"
	else
		vim.api.nvim_set_hl(0, hl_winbar_path, { fg = "black", bg = "#e6e9ef" })
	end

	if f.isempty(opts.colors.file_name) then
		hl_winbar_file = "String"
	else
		vim.api.nvim_set_hl(0, hl_winbar_file, { fg = "#40A02B", bg = "#e6e9ef" })
	end
end

M.show_winbar = function()
	if excludes() then
		return
	end

	local value = winbar_file()

	local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
	if not status_ok then
		return
	end
end

return M
