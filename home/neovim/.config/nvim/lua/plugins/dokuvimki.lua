-- ~/.config/nvim/lua/plugins/dokuvimki.lua

return {
  {
    "kynan/dokuvimki",
    config = function()
      -- Configure the DokuWiki plugin
      vim.g.DokuVimKi_USER = "your_username"
      vim.g.DokuVimKi_PASS = "your_password"
      vim.g.DokuVimKi_URL = "https://yourwikidomain.org"
      vim.g.DokuVimKi_HTTP_BASIC_AUTH = 1
      vim.g.DokuVimKi_INDEX_WINWIDTH = 40
      vim.g.DokuVimKi_DEFAULT_SUM = "default summary"
    end,
    cmd = "DokuVimKi", -- Lazy load on DokuVimKi command
  },
}
