local ts_utils = require("nvim-treesitter.ts_utils")
local M = {}

M.setup = function()
	--nothing rn
end

M.get_function = function()
	local node = ts_utils.get_node_at_cursor(0, true)
	if not node then
		print("Treesitter failed to parse node")
		return nil
	end

	local func_name = vim.treesitter.get_node_text(node, 0)

	return func_name
end

M.open_window = function()
	local func_name = M.get_function()
	if not func_name then
		return
	end

	local def = { func_name }

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, def)

	local width = math.floor(vim.o.columns * 0.4)
	local height = math.floor(vim.o.lines * 0.4)
	local opts = {
		relative = "cursor",
		width = width,
		height = height,
		col = 0,
		row = 1,
		style = "minimal",
		border = "rounded",
	}

	vim.api.nvim_open_win(buf, true, opts)
end

vim.api.nvim_set_keymap(
	"n",
	"<leader>ep",
	":lua require('ezprev').open_window(require('ezprev').get_function())<CR>",
	{ noremap = true, silent = true }
)

return M
