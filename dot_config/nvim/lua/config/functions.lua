function vim.GetVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

function vim.CloseBufferSafely()
	local current_buf = vim.api.nvim_get_current_buf()
	vim.cmd("bnext")
	if vim.api.nvim_get_current_buf() == current_buf then
		vim.cmd("bprevious")
	end

	if vim.api.nvim_get_current_buf() ~= current_buf then
		vim.api.nvim_buf_delete(current_buf, { force = true })
	end
end

function vim.CloseBuffer()
	if vim.bo.buftype == "terminal" then
		vim.cmd("bw!")
	elseif vim.bo.buftype == "quickfix" then
		vim.cmd("bd!")
	elseif vim.bo.buftype == "help" then
		vim.cmd("bd")
	else
		vim.CloseBufferSafely()
	end
end
