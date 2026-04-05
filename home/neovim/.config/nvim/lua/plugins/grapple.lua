-- ============================================================================
-- File Marking: Grapple.nvim - Fast File Switching
-- ============================================================================
-- Architecture: Tag-based file navigation with persistent markers
-- Performance: O(1) file access; lazy-loaded on first use
-- Trade-off: More feature-rich than Harpoon; similar UX paradigm

return {
  {
    "cbochs/grapple.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
      { "<leader>m", "<cmd>Grapple toggle<CR>", desc = "Toggle tag" },
      { "<leader>M", "<cmd>Grapple toggle_tags<CR>", desc = "Toggle tags menu" },
      { "<leader>1", "<cmd>Grapple select index=1<CR>", desc = "Select tag 1" },
      { "<leader>2", "<cmd>Grapple select index=2<CR>", desc = "Select tag 2" },
      { "<leader>3", "<cmd>Grapple select index=3<CR>", desc = "Select tag 3" },
      { "<leader>4", "<cmd>Grapple select index=4<CR>", desc = "Select tag 4" },
      { "<leader>5", "<cmd>Grapple select index=5<CR>", desc = "Select tag 5" },
      { "<C-n>", "<cmd>Grapple cycle_tags next<CR>", desc = "Next tag" },
      { "<C-p>", "<cmd>Grapple cycle_tags prev<CR>", desc = "Previous tag" },
    },
    opts = {
      scope = "git_branch", -- Options: git, git_branch, lsp, cwd
      icons = true,
      status = false,
      style = "basename", -- Options: basename, relative, full
      prune = "30d",
      win_opts = {
        border = "rounded",
        width = 80,
        height = 12,
      },
      integrations = {
        resession = false,
      },
    },
  },
}
