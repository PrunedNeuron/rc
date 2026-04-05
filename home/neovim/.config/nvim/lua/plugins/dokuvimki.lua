-- ============================================================================
-- DokuWiki Integration: DokuVimKi
-- ============================================================================
-- Architecture: XML-RPC client for DokuWiki API
-- Performance: Lazy-loaded on DokuVimKi command; async HTTP operations
-- Security: Credentials via environment variables (never hardcoded)

return {
  {
    "kynan/dokuvimki",
    cmd = "DokuVimKi",
    ft = "dokuwiki",
    keys = {
      { "<leader>dw", "<cmd>DokuVimKi<CR>", desc = "DokuWiki" },
    },
    config = function()
      -- SECURITY: Load credentials from environment variables
      -- Set these in your shell config: export DOKUVIMKI_USER="username"
      vim.g.DokuVimKi_USER = vim.env.DOKUVIMKI_USER or ""
      vim.g.DokuVimKi_PASS = vim.env.DOKUVIMKI_PASS or ""
      vim.g.DokuVimKi_URL = vim.env.DOKUVIMKI_URL or ""
      
      -- Configuration
      vim.g.DokuVimKi_HTTP_BASIC_AUTH = 1
      vim.g.DokuVimKi_INDEX_WINWIDTH = 40
      vim.g.DokuVimKi_DEFAULT_SUM = "Updated via Neovim"
      
      -- Warn if credentials not set
      if vim.g.DokuVimKi_USER == "" or vim.g.DokuVimKi_URL == "" then
        vim.notify(
          "DokuVimKi: Set DOKUVIMKI_USER, DOKUVIMKI_PASS, DOKUVIMKI_URL environment variables",
          vim.log.levels.WARN
        )
      end
    end,
  },
}
