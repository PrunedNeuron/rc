-- ============================================================================
-- Autocommands - Event-driven Configuration
-- ============================================================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ============================================================================
-- COLORSCHEME PERSISTENCE
-- ============================================================================

autocmd("ColorScheme", {
  group = augroup("colorscheme_persistence", { clear = true }),
  callback = function()
    require("config.colorscheme").save()
  end,
  desc = "Save colorscheme on change",
})

-- ============================================================================
-- GENERAL
-- ============================================================================

autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
  desc = "Highlight yanked text briefly",
})

autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "Resize splits on terminal resize",
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime", { clear = true }),
  command = "checktime",
  desc = "Check if buffer changed outside Neovim",
})

-- ============================================================================
-- FILETYPE-SPECIFIC
-- ============================================================================

autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = {
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "startuptime",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
  desc = "Close certain windows with 'q'",
})

autocmd("FileType", {
  group = augroup("wrap_spell", { clear = true }),
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  desc = "Enable wrap and spell for text files",
})

autocmd("BufWritePre", {
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Auto-create parent directories when saving",
})

-- ============================================================================
-- LSP
-- ============================================================================

autocmd("BufWritePre", {
  group = augroup("lsp_format_on_save", { clear = true }),
  callback = function(event)
    local conform = require("conform")
    if conform then
      conform.format({ bufnr = event.buf, lsp_fallback = true, timeout_ms = 500 })
    end
  end,
  desc = "Format on save using conform.nvim",
})

-- ============================================================================
-- TERMINAL
-- ============================================================================

autocmd("TermOpen", {
  group = augroup("term_settings", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
  desc = "Terminal settings and auto insert mode",
})

-- ============================================================================
-- PERFORMANCE
-- ============================================================================

autocmd("BufReadPre", {
  group = augroup("large_file", { clear = true }),
  callback = function(event)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(event.buf))
    if ok and stats and stats.size > 100000 then
      vim.b.large_file = true
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.syntax = "off"
    end
  end,
  desc = "Disable features for large files (>100KB)",
})
