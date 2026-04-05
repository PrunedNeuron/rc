-- ============================================================================
-- Colorscheme Collection - Multi-theme Support
-- ============================================================================
-- Architecture: Multiple lazy-loaded colorschemes with single active scheme
-- Persistence: Colorscheme selection saved to ~/.cache/nvim/colorscheme.txt

return {
  -- Catppuccin (default)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
      styles = {
        comments = { "italic" },
        keywords = { "italic" },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        neotree = true,
        treesitter = true,
        notify = true,
        mini = { enabled = true },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = { background = true },
        },
        telescope = { enabled = true },
        which_key = true,
        mason = true,
        noice = true,
        blink_cmp = true,
      },
    },
  },

  -- Cyberdream
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = true,
      italic_comments = true,
      hide_fillchars = false,
      borderless_telescope = true,
      terminal_colors = true,
    },
  },

  -- Tokyo Night
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    },
  },

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      terminal_colors = true,
      italic = {
        comments = true,
        emphasis = true,
      },
    },
  },

  -- Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
    opts = {
      variant = "main",
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    },
  },

  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      transparent = true,
      theme = "wave",
    },
  },

  -- Nightfox
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      options = {
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = "italic",
          keywords = "bold",
        },
      },
    },
  },

  -- OneDark
  {
    "navarasu/onedark.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "dark",
      transparent = false,
      term_colors = true,
      code_style = {
        comments = "italic",
      },
    },
  },

  -- BluLoco
  {
    "uloco/bluloco.nvim",
    lazy = true,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    opts = {
      style = "dark",
      transparent = false,
      term_colors = true,
      code_style = {
        comments = "italic",
      },
    },
  },
}
