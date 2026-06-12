local format_on_save_enabled = true

local augroup = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	callback = function(args)
		if not format_on_save_enabled then
			return
		end

		local buf = args.buf

		if vim.bo[buf].buftype ~= "" or not vim.bo[buf].modifiable then
			return
		end

		local clients = vim.lsp.get_clients({ bufnr = buf })
		for _, c in ipairs(clients) do
			if c.name == "efm" then
				vim.lsp.buf.format({
					bufnr = buf,
					timeout_ms = 2000,
					filter = function(client)
						return client.name == "efm"
					end,
				})
				return
			end
		end
	end,
})

-- Create toggle command
vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
	format_on_save_enabled = not format_on_save_enabled
	print("Format on save: " .. (format_on_save_enabled and "ON" or "OFF"))
end, {})

-- return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})
