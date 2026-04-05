-- ============================================================================
-- Custom Keymaps - Ergonomic and Efficient
-- ============================================================================

local map = vim.keymap.set

-- ============================================================================
-- BETTER DEFAULTS
-- ============================================================================

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

map("v", "p", '"_dP', { desc = "Paste without yank" })

-- ============================================================================
-- BUFFER MANAGEMENT
-- ============================================================================

map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<CR>", { desc = "Force delete buffer" })

-- ============================================================================
-- FILE OPERATIONS
-- ============================================================================

map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Quit all (force)" })

-- ============================================================================
-- COLORSCHEME SWITCHING
-- ============================================================================

map("n", "<leader>uC", function()
  require("telescope.builtin").colorscheme({ enable_preview = true })
end, { desc = "Colorscheme picker (preview)" })

map("n", "<leader>un", function()
  require("config.colorscheme").cycle(1)
end, { desc = "Next colorscheme" })

map("n", "<leader>up", function()
  require("config.colorscheme").cycle(-1)
end, { desc = "Previous colorscheme" })

map("n", "<leader>u1", function()
  require("config.colorscheme").set("catppuccin-mocha")
end, { desc = "Catppuccin Mocha" })

map("n", "<leader>u2", function()
  require("config.colorscheme").set("cyberdream")
end, { desc = "Cyberdream" })

map("n", "<leader>u3", function()
  require("config.colorscheme").set("tokyonight")
end, { desc = "Tokyo Night" })

map("n", "<leader>u4", function()
  require("config.colorscheme").set("gruvbox")
end, { desc = "Gruvbox" })

map("n", "<leader>u5", function()
  require("config.colorscheme").set("rose-pine")
end, { desc = "Rose Pine" })

-- ============================================================================
-- TERMINAL
-- ============================================================================

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Go to right window" })

-- ============================================================================
-- QUICKFIX & LOCATION LIST
-- ============================================================================

map("n", "<leader>xq", "<cmd>copen<CR>", { desc = "Open quickfix list" })
map("n", "<leader>xl", "<cmd>lopen<CR>", { desc = "Open location list" })
map("n", "[q", "<cmd>cprevious<CR>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "[l", "<cmd>lprevious<CR>", { desc = "Previous location" })
map("n", "]l", "<cmd>lnext<CR>", { desc = "Next location" })

-- ============================================================================
-- DIAGNOSTIC NAVIGATION
-- ============================================================================

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Previous error" })
map("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })

-- ============================================================================
-- UTILITY
-- ============================================================================

map("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
