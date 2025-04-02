local M = {}

M.setup = function()
	M.use_keymaps()
end

M.open_window = function(def, pos)
	local buf = type(def) == "string" and vim.uri_to_bufnr(def) or def

	local width = math.floor(vim.o.columns * 0.4)
	local height = math.floor(vim.o.lines * 0.6)
	local opts = {
		relative = "cursor",
		width = width,
		height = height,
		col = 0,
		row = 1,
		style = "minimal",
		border = "rounded",
	}

	local window = vim.api.nvim_open_win(buf, true, opts)
	vim.api.nvim_win_set_cursor(window, pos)
end

M.get_config = function(data)
	local uri = data.targetUri or data.uri
	local range = data.targetRange or data.range

	return uri, { range.start.line + 1, range.start.character }
end

local process = function()
	return function(_, result, _)
		if not result then
			return
		end
		local data = result[1] or result
		local target = nil
		local pos = {}

		if vim.tbl_isempty(data) then
			print("No definition found")
			return
		end

		target, pos = M.get_config(data)

		M.open_window(target, pos)
	end
end

M.get_handler = function()
	for k, v in pairs(vim.lsp.handlers) do
		if string.find(k, "textDocument") and type(v) == "function" then
			return process()
		end
	end
end

M.get_definition = function()
	local params = vim.lsp.util.make_position_params()
	local method = "textDocument/implementation"
	pcall(vim.lsp.buf_request, 0, method, params, M.get_handler())
end

M.get_declaration = function()
	local params = vim.lsp.util.make_position_params()
	-- idk what this needs to be
	local method = "textDocument/declaration"
	pcall(vim.lsp.buf_request, 0, method, params, M.get_handler())
end

M.use_keymaps = function()
	vim.api.nvim_set_keymap(
		"n",
		"<leader>gd",
		":lua require('ezprev').get_definition()<CR>",
		{ noremap = true, silent = true }
	)

	--vim.api.nvim_set_keymap(
	--	"n",
	--	"<leader>gd",
	--	":lua require('ezprev').get_declaration()<CR>",
	--	{ noremap = true, silent = true }
	--)
end

return M
