-- Plugin initialization

-- Telescope
require('config/telescope')

-- lualine
require('config/lualine')

-- Autosave
require('config/autosave')

-- nvim-cmp
require('config/cmp')

-- neovim-lspconfig
require('config/lspconfig')


-- no config required

-- Neoscroll (smooth scrolling)
require('neoscroll').setup()

-- Comment shortcuts
require('nvim_comment').setup()

-- Key map (which-key)
require('which-key').setup()

-- comment frame
require('nvim-comment-frame').setup()

-- Project (project management, auto cd)
require('project_nvim').setup()

-- lightbulb
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]


