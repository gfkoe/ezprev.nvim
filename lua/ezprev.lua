local M = {}

M.setup = function()
	--nothing rn
end

M.get_definition = function()
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result)
		if not result or vim.tbl_isempty(result) then
			print("No definition found")
			return
		end
	end)
	return nil
end

M.open_window = function(def)
	if not def then
		return
	end

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
	":lua require('ezprev').get_definition()<CR>",
	{ noremap = true, silent = true }
)

return M
