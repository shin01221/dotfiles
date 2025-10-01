local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- my keymaps
keymap.set("n", "--", vim.cmd.Oil)
keymap.set("n", "tt", vim.cmd.Themery)
-- keymap.set("n", "gs", vim.cmd.LiveServerStart)
-- keymap.set("n", "gq", vim.cmd.LiveServerStop)

-- Select all
keymap.set("n", "aa", "gg<S-v>G")

-- keep window centered when going up/down
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
-- keymap.set("n", "j", "jzz")
-- keymap.set("n", "k", "kzz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "vv", "0v$h")
-- keymap.set("n", "s", "")
keymap.set("i", "jj", "<esc>")
keymap.set("n", "gf", "<C-W>gf")
-- keymap.set("x", "<leader>p", '"_dp')

-- Do things without affecting the registers
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

-- code-runner
-- vim.keymap.set("n", "<leader>r", ":w<CR>:!python3 %<CR>", { noremap = true, silent = true })
-- keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = false })
-- keymap.set("n", "<leader>rff", ":RunFile<CR>", { noremap = true, silent = false })
-- keymap.set("n", "<leader>rft", ":RunFile tab<CR>", { noremap = true, silent = false })
-- keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })
-- keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false })
-- keymap.set("n", "<leader>raa", ":CRFiletype<CR>", { noremap = true, silent = false })
-- keymap.set("n", "<leader>rab", ":CRProjects<CR>", { noremap = true, silent = false })

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
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

-- Resize window
-- keymap.set("n", "<C-w><right>", "<C-w><")
-- keymap.set("n", "<C-w><left>", "<C-w>>")
-- keymap.set("n", "<C-w><down>", "<C-w>+")
-- keymap.set("n", "<C-w><up>", "<C-w>-")

keymap.set("n", "<C-w><l>", "<C-w><")
keymap.set("n", "<C-w><h>", "<C-w>>")
keymap.set("n", "<C-w><j>", "<C-w>+")
keymap.set("n", "<C-w><k>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<A-d>", function()
  vim.diagnostic.goto_next()
end, opts)

-- keymap.set("n", "<leader>r", function()
--   require("craftzdog.hsl").replaceHexWithHSL()
-- end)
--
-- keymap.set("n", "<leader>i", function()
--   require("craftzdog.lsp").toggleInlayHints()
-- end)

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- obsidian  keymaps
-- keymap.set("n", "<leader>os", ':Telescope find_files search_dirs={"/media/Docs/notes/"}<cr>', { desc = "search notes" })
keymap.set(
  "n",
  "<leader>og",
  ':Telescope live_grep search_dirs={"/media/Docs/notes"}<cr>',
  { desc = "live grep in notes" }
)

-- keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "NextBuffer" })
-- keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "PrevBuffer" })
keymap.set("n", "<leader>o", "", { desc = "+obsidian" })
keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "New Note" })
keymap.set("n", "<leader>ot", vim.cmd.ObsidianNewFromTemplate, { desc = "New Note with template" })
keymap.set("n", "<leader>od", vim.cmd.ObsidianDailies, { desc = "New Daily Note" })
keymap.set("n", "<leader>os", vim.cmd.ObsidianQuickSwitch, { desc = "Notes QuickSwitch" })
keymap.set("n", "<leader>oh", vim.cmd.ObsidianTags, { desc = "Search Tags" })
keymap.set("n", "<leader>oc", vim.cmd.ObsidianTOC, { desc = "Search TOC" })
keymap.set("n", "<leader>ob", vim.cmd.ObsidianBacklinks, { desc = "Search backlinks" })
keymap.set("n", "<leader>ols", vim.cmd.ObsidianLinks, { desc = "Search Links" })
-- keymap.set("v", "<leader>oe", "<cmd>ObsidianExtractNote<cr>", { desc = "Note Extract" })
keymap.set("v", "<leader>ox", ":ObsidianExtractNote", { desc = "Note Extract" })
keymap.set("v", "<leader>oll", vim.cmd.ObsidianLinkNew, { desc = "New Link" })

-- molten kyemaps
keymap.set("n", "<leader>me", vim.cmd.MoltenEvaluateLine, { desc = "LineEvaluate" })
keymap.set("n", "<leader>mq", vim.cmd.MoltenDeinit, { desc = "LineEvaluate" })

keymap.set("n", "gf", function()
  if require("obsidian").util.cursor_on_markdown_link() then
    return "<cmd>ObsidianFollowLink<CR>"
  else
    return "gf"
  end
end, { noremap = false, expr = true })

--color picker
keymap.set("n", "<C-t>", function()
  require("minty.huefy").open()
end, {})

keymap.set("n", "<C-i>", function()
  require("minty.shades").open()
end, {})

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
