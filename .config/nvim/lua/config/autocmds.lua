-- vim.cmd([[
-- augroup kitty_mp
--     autocmd!
--     au VimLeave * if !empty($KITTY_WINDOW_ID) | :silent !kitty @ set-spacing padding=20 margin=0
--     au VimEnter * if !empty($KITTY_WINDOW_ID) | :silent !kitty @ set-spacing padding=0 margin=0
--     au BufEnter * if !empty($KITTY_WINDOW_ID) | :silent !kitty @ set-spacing padding=0 margin=0
-- augroup END
-- ]])
-- disable indent lines for markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.b.snacks_indent = false
	end,
})
