-- Plugin initialization

-- comment frame
require("nvim-comment-frame").setup()

-- Telescope
require("telescope").setup()

-- Zen mode
require("zen-mode").setup()

-- Twilight
require("twilight").setup()

-- Neoscroll (smooth scrolling)
require("neoscroll").setup()

-- Comment shortcuts
require("nvim_comment").setup()

-- lualine
require("lualine").setup(
    {
        options = {
            theme = "ayu_light"
        }
    }
)

-- Autosave
require("autosave").setup(
    {
     enabled = true,
     execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
     events = {"InsertLeave", "TextChanged"},
     conditions = {
                   exists = true,
                   filetype_is_not = {},
                   modifiable = true
                  },
     write_all_buffers = false,
     on_off_commands = true,
     clean_command_line_interval = 0,
     debounce_delay = 135
    }
)

-- lightbulb
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

-- glow (markdown reader)
vim.g.glow_binary_path = "/usr/bin"

