local M = {}

M.setup = function()
	--nothing rn
end

local process = function(method)
	if not method then
		return
	end
	local data = method[1] or method
	local target = nil
	local pos = {}
	local uri = data.targetUri or data.uri
	local range = data.targetRange or data.range

	if uri and range then
		target = uri
		pos.start = range.start.line + 1
		pos["end"] = range.start.character
	end
	M.open_window(target, pos)
end

M.get_handler = function(method)
	for k, v in pairs(vim.lsp.handlers) do
		if string.find(k, "textDocument") and type(v) == "function" then
			return process(method)
		end
	end
end

M.get_definition = function()
	local params = vim.lsp.util.make_position_params()
	local method = "textDocument/implementation"
	pcall(vim.lsp.buf_request, 0, method, params, M.get_handler(method))
end

M.open_window = function(def, pos)
	local buf = type(def) == "string" and vim.uri_to_bufnr(def) or def

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

	local window = vim.api.nvim_open_win(buf, true, opts)
	vim.api.nvim_win_set_cursor(window, pos)
end

vim.api.nvim_set_keymap(
	"n",
	"<leader>gd",
	":lua require('ezprev').get_definition()<CR>",
	{ noremap = true, silent = true }
)

return M
