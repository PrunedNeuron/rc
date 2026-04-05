-- ============================================================================
-- Lazy.nvim Plugin Manager Configuration
-- ============================================================================
-- Performance: lazy.nvim uses lazy-loading to achieve <50ms startup time
-- Architecture: Modular plugin specs loaded from lua/plugins/*.lua
-- CRITICAL: Import order must be: lazyvim.plugins → extras → custom plugins

require("lazy").setup({
  spec = {
    -- FIRST: Core LazyVim framework
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = "catppuccin-mocha",
        news = {
          lazyvim = false,
          neovim = false,
        },
      },
    },

    -- SECOND: LazyVim extras (language support, formatters, etc.)
-- Python support
{ import = "lazyvim.plugins.extras.lang.python" },
-- TypeScript/JavaScript support
{ import = "lazyvim.plugins.extras.lang.typescript" },
-- JSON schema validation
{ import = "lazyvim.plugins.extras.lang.json" },
-- Markdown preview and editing
{ import = "lazyvim.plugins.extras.lang.markdown" },
-- Black formatter for Python
{ import = "lazyvim.plugins.extras.formatting.black" },
-- Docker support
{ import = "lazyvim.plugins.extras.lang.docker" },
-- YAML schema validation
{ import = "lazyvim.plugins.extras.lang.yaml" },
-- Mini patterns
{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
-- Project management
{ import = "lazyvim.plugins.extras.util.project" },

-- THIRD: Custom plugins from lua/plugins/
{ import = "plugins" },
  },

  defaults = {
    lazy = true, -- Lazy-load all plugins by default
    version = false, -- Use HEAD for latest features (stable tested by LazyVim)
  },

  -- UI: Modern floating window configuration
  ui = {
    border = "rounded",
    backdrop = 60,
    size = { width = 0.8, height = 0.8 },
  },

  -- Performance optimizations
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- Disable unused built-in plugins for faster startup
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },

  -- Auto-update check
  checker = {
    enabled = true,
    notify = false, -- Disable notifications (check via :Lazy)
frequency = 3600, -- Check every hour
  },

  -- Change detection for config files
  change_detection = {
    enabled = true,
    notify = false, -- Disable notifications to avoid clutter
  },

  -- Install configuration
  install = {
    colorscheme = { "catppuccin-mocha", "tokyonight", "habamax" },
  },

  -- Development mode
  dev = {
    path = "~/projects",
    patterns = {}, -- Add your local plugin dev paths here
    fallback = false,
  },
})
