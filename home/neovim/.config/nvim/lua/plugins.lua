-- Plugin initialization

-- comment frame
require("nvim-comment-frame").setup()

-- Project (project management, auto cd)
require("project_nvim").setup()

-- Telescope
-- require("telescope").load_extension("projects")
-- require("telescope").setup()

-- Twilight
-- require("twilight").setup()

-- Neoscroll (smooth scrolling)
require("neoscroll").setup()

-- Comment shortcuts
require("nvim_comment").setup()

-- Key map (which-key)
require("which-key").setup()

-- lualine
require("lualine").setup(
    {
        options = {
            theme = "ayu_light"
        }
    }
)

-- nvim-tree
require("nvim-tree").setup()

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

