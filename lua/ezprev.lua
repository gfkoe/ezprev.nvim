local M = {}

M.setup = function()
	--nothing rn
end

--@param definition: table
M.open_window = function(definition)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, definition)

	local width = math.floor(vim.o.columns * 0.4)
	local height = math.floor(vim.o.lines * 0.4)
	local opts = {
		relative = "cursor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	}

	vim.api.nvim_open_win(buf, true, opts)
end

vim.api.nvim_set_keymap(
	"n",
	"<leader>ep",
	":lua require('ezprev').open_window({'Hello', 'World'})<CR>",
	{ noremap = true, silent = true }
)

return M
