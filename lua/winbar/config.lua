local M = {}

M.defaults = {
	show_file_path = true,

	colors = {
		path = "#e6e9ef",
		file_name = "red",
	},

	icons = {
		seperator = ">",
		editor_state = "●",
		lock_icon = "",
	},

	exclude_filetype = {
		"help",
		"startify",
		"dashboard",
		"packer",
		"neogitstatus",
		"NvimTree",
		"Trouble",
		"alpha",
		"lir",
		"Outline",
		"spectre_panel",
		"toggleterm",
		"qf",
	},
}

M.options = {}

function M.set_options(opts)
	M.options = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end

return M
