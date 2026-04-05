-- ============================================================================
-- Colorscheme Picker: Telescope Integration
-- ============================================================================
-- Fix: Ensure Telescope loads before command execution
-- Architecture: Lazy-load Telescope on first picker invocation

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>uC",
        function()
          -- Force load Telescope before using it
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end,
        desc = "Colorscheme (with preview)",
      },
    },
    -- Configure colorscheme picker defaults
    opts = function(_, opts)
      opts = opts or {}
      opts.pickers = opts.pickers or {}
      opts.pickers.colorscheme = {
        enable_preview = true,
      }
      return opts
    end,
  },
}
