return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "folke/tokyonight.nvim" },
  { "bluz71/vim-nightfly-colors" },
  { "yonlu/omni.vim" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "omni",
    },
  },
}
