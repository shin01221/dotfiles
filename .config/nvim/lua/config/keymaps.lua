local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "NextBuffer" })
-- keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "PrevBuffer" })
-- plugins

-- keymap.set("n", "tt", vim.cmd.Themery)
keymap.set("n", "tt", "<cmd>Themify<cr>")
-- toggle markview
keymap.set("n", "<leader>um", "<cmd>Markview Toggle<cr>", { desc = "Toggle markdwon" })
--toggle top bar buffer on or off
keymap.set("n", "<leader>bs", function()
	if vim.o.showtabline == 0 then
		vim.o.showtabline = 2
	else
		vim.o.showtabline = 0
	end
end, { desc = "Toggle bufferline visibility" })
vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "Format current file" })

-- obsidian  keymaps
keymap.set(
	"n",
	"<leader>og",
	':Telescope live_grep search_dirs={"/Media/Docs/notes"}<cr>',
	{ desc = "live grep in notes" }
)
-- keymap.set("n", "<leader>os", function()
-- 	Snacks.picker.files({
-- 		cwd = "/Media/Docs/notes/",
-- 	})
-- end, { desc = "Notes search" })
keymap.set("v", "<leader>oe", "<cmd>ObsidianExtractNote<cr>", { desc = "Note Extract" })
keymap.set("v", "<leader>ox", ":ObsidianExtractNote", { desc = "Note Extract" })
keymap.set("v", "<leader>oll", vim.cmd.ObsidianLinkNew, { desc = "New Link" })
keymap.set("n", "<leader>l", "<cmd>ObsidianToggleCheckbox<cr>", { desc = "Checkbox Toggle" })
keymap.set("n", "<leader>ols", vim.cmd.ObsidianLinks, { desc = "Search Links" })
keymap.set("n", "<leader>op", vim.cmd.ObsidianPasteImg, { desc = "Paste Image" })
keymap.set("n", "<leader>o", "", { desc = "+obsidian" })
keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "New Note" })
keymap.set("n", "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Search notes" })
keymap.set("n", "<leader>ot", vim.cmd.ObsidianNewFromTemplate, { desc = "New Note with template" })
keymap.set("n", "<leader>od", vim.cmd.ObsidianDailies, { desc = "New Daily Note" })
keymap.set("n", "<leader>oh", vim.cmd.ObsidianTags, { desc = "Search Tags" })
keymap.set("n", "<leader>oc", vim.cmd.ObsidianTOC, { desc = "Search TOC" })
keymap.set("n", "<leader>ob", vim.cmd.ObsidianBacklinks, { desc = "Search backlinks" })

keymap.set("n", "gf", function()
	if require("obsidian").util.cursor_on_markdown_link() then
		return "<cmd>ObsidianFollowLink<CR>"
	else
		return "gf"
	end
end, { noremap = false, expr = true })

-------------------------------------------------------------------------------
--                           Folding section
-------------------------------------------------------------------------------

-- Use <CR> to fold when in normal mode
-- To see help about folds use `:help fold`
vim.keymap.set("n", "<CR>", function()
	-- Get the current line number
	local line = vim.fn.line(".")
	-- Get the fold level of the current line
	local foldlevel = vim.fn.foldlevel(line)
	if foldlevel == 0 then
		vim.notify("No fold found", vim.log.levels.INFO)
	else
		vim.cmd("normal! za")
	end
end, { desc = "[P]Toggle fold" })

local function set_foldmethod_expr()
	-- These are lazyvim.org defaults but setting them just in case a file
	-- doesn't have them set
	if vim.fn.has("nvim-0.10") == 1 then
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
		vim.opt.foldtext = ""
	else
		vim.opt.foldmethod = "indent"
		vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
	end
	vim.opt.foldlevel = 99
end

-- Function to fold all headings of a specific level
local function fold_headings_of_level(level)
	-- Move to the top of the file
	vim.cmd("normal! gg")
	-- Get the total number of lines
	local total_lines = vim.fn.line("$")
	for line = 1, total_lines do
		-- Get the content of the current line
		local line_content = vim.fn.getline(line)
		-- "^" -> Ensures the match is at the start of the line
		-- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
		-- "%s" -> Matches any whitespace character after the "#" characters
		-- So this will match `## `, `### `, `#### ` for example, which are markdown headings
		if line_content:match("^" .. string.rep("#", level) .. "%s") then
			-- Move the cursor to the current line
			vim.fn.cursor(line, 1)
			-- Fold the heading if it matches the level
			if vim.fn.foldclosed(line) == -1 then
				vim.cmd("normal! za")
			end
		end
	end
end

local function fold_markdown_headings(levels)
	set_foldmethod_expr()
	-- I save the view to know where to jump back after folding
	local saved_view = vim.fn.winsaveview()
	for _, level in ipairs(levels) do
		fold_headings_of_level(level)
	end
	vim.cmd("nohlsearch")
	-- Restore the view to jump to where I was
	vim.fn.winrestview(saved_view)
end

-- Keymap for unfolding markdown headings of level 2 or above
vim.keymap.set("n", "<leader>ofu", function()
	-- Reloads the file to reflect the changes
	vim.cmd("edit!")
	vim.cmd("normal! zR") -- Unfold all headings
end, { desc = "[P]Unfold all headings level 2 or above" })

-- Keymap for folding markdown headings of level 1 or above
vim.keymap.set("n", "<leader>ofj", function()
	-- Reloads the file to refresh folds, otherwise you have to re-open neovim
	vim.cmd("edit!")
	-- Unfold everything first or I had issues
	vim.cmd("normal! zR")
	fold_markdown_headings({ 6, 5, 4, 3, 2, 1 })
end, { desc = "[P]Fold all headings level 1 or above" })

-- Keymap for folding markdown headings of level 2 or above
-- I know, it reads like "madafaka" but "k" for me means "2"
vim.keymap.set("n", "<leader>ofk", function()
	-- Reloads the file to refresh folds, otherwise you have to re-open neovim
	vim.cmd("edit!")
	-- Unfold everything first or I had issues
	vim.cmd("normal! zR")
	fold_markdown_headings({ 6, 5, 4, 3, 2 })
end, { desc = "[P]Fold all headings level 2 or above" })

-- Keymap for folding markdown headings of level 3 or above
vim.keymap.set("n", "<leader>ofl", function()
	-- Reloads the file to refresh folds, otherwise you have to re-open neovim
	vim.cmd("edit!")
	-- Unfold everything first or I had issues
	vim.cmd("normal! zR")
	fold_markdown_headings({ 6, 5, 4, 3 })
end, { desc = "[P]Fold all headings level 3 or above" })

-- Keymap for folding markdown headings of level 4 or above
vim.keymap.set("n", "<leader>of;", function()
	-- Reloads the file to refresh folds, otherwise you have to re-open neovim
	vim.cmd("edit!")
	-- Unfold everything first or I had issues
	vim.cmd("normal! zR")
	fold_markdown_headings({ 6, 5, 4 })
end, { desc = "[P]Fold all headings level 4 or above" })

-------------------------------------------------------------------------------
--                         End Folding section
-------------------------------------------------------------------------------

-- convienince

-- keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "NextBuffer" })
-- keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "PrevBuffer" })

vim.keymap.set("n", "gl", function()
	vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })

-- Clear highlights on search when pressing <Esc> in normal mode
keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "NextBuffer" })
keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "PrevBuffer" })

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Select all
keymap.set("n", "aa", "gg<S-v>G")
keymap.set("n", "<C-a>", "gg<S-v>G")
keymap.set("n", "vv", "0v$h")
keymap.set("i", "jj", "<esc>")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "gf", "<C-W>gf")

-- deletion don't affect buffer
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
keymap.set("n", "qq", vim.cmd.q)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")
keymap.set("n", "<c-k>", "<C-w>k")
keymap.set("n", "c-j>", "<C-w>j")
keymap.set("n", "c-h>", "<C-w>h")
keymap.set("n", "<c-l>", "<C-w>l")

-- resize window
keymap.set("n", "<C-w><l>", "<C-w><")
keymap.set("n", "<C-w><h>", "<C-w>>")
keymap.set("n", "<C-w><j>", "<C-w>+")
keymap.set("n", "<C-w><k>", "<C-w>-")

-- move highlited text
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
