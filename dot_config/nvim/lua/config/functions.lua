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

function vim.CloseBuffer()
	if vim.bo.buftype == "terminal" then
		vim.cmd("bw!")
	else
		vim.cmd("Bclose")
	end
end
