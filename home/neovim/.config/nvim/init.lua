-- ============================================================================
-- Modern Neovim Configuration (2025)
-- ============================================================================

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys BEFORE lazy.nvim loads
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load LazyVim and all configurations
require("config.lazy")

-- DokuWiki detection function
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.txt",
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, 20, false)
    for _, line in ipairs(lines) do
      if line:match("^ *=\\{2,6\\}.+\\1 *$") then
        vim.opt_local.textwidth = 0
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.bo.filetype = "dokuwiki"
        break
      end
    end
  end,
})

-- Restore saved colorscheme on startup
vim.schedule(function()
  local cs = require("config.colorscheme")
  local saved = cs.load()

  if saved and saved ~= "" then
    -- Attempt to load saved colorscheme
    pcall(vim.cmd.colorscheme, saved)
  else
    -- Fallback to default
    pcall(vim.cmd.colorscheme, "catppuccin-mocha")
  end

  -- Ensure it saves after initial load
  cs.save()
end)
