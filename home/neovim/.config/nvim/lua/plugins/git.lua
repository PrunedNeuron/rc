-- ============================================================================
-- Git Interface: Neogit - Magit-inspired Git Client
-- ============================================================================
-- Architecture: Buffer-based Git UI with transactional commits
-- Performance: Async operations; lazy-loaded on Git commands
-- Trade-off: More powerful than vim-fugitive; steeper learning curve

return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<CR>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Neogit push<CR>", desc = "Git push" },
      { "<leader>gP", "<cmd>Neogit pull<CR>", desc = "Git pull" },
      { "<leader>gb", "<cmd>Neogit branch<CR>", desc = "Git branch" },
    },
    opts = {
      disable_signs = false,
      disable_hint = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      disable_insert_on_commit = false,
      filewatcher = {
        interval = 1000,
        enabled = true,
      },
      git_services = {
        ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
        ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/-/merge_requests/new?merge_request[source_branch]=${branch_name}",
      },
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
      end,
      remember_settings = true,
      use_per_project_settings = true,
      ignored_settings = {},
      auto_refresh = true,
      sort_branches = "-committerdate",
      kind = "tab", -- Options: tab, split, vsplit, floating
      disable_line_numbers = true,
      console_timeout = 2000,
      auto_show_console = true,
      notification_icon = "󰊢",
      graph_style = "unicode",
      commit_editor = {
        kind = "tab",
      },
      commit_select_view = {
        kind = "tab",
      },
      commit_view = {
        kind = "vsplit",
        verify_commit = vim.fn.executable("gpg") == 1,
      },
      log_view = {
        kind = "tab",
      },
      rebase_editor = {
        kind = "auto",
      },
      reflog_view = {
        kind = "tab",
      },
      merge_editor = {
        kind = "auto",
      },
      tag_editor = {
        kind = "auto",
      },
      preview_buffer = {
        kind = "split",
      },
      popup = {
        kind = "split",
      },
      signs = {
        hunk = { "", "" },
        item = { "", "" },
        section = { "", "" },
      },
      integrations = {
        telescope = true,
        diffview = true,
      },
      sections = {
        untracked = {
          folded = false,
        },
        unstaged = {
          folded = false,
        },
        staged = {
          folded = false,
        },
        stashes = {
          folded = true,
        },
        unpulled_upstream = {
          folded = true,
        },
        unmerged_upstream = {
          folded = false,
        },
        unpulled_pushRemote = {
          folded = true,
        },
        unmerged_pushRemote = {
          folded = false,
        },
        recent = {
          folded = true,
        },
        rebase = {
          folded = true,
        },
      },
      mappings = {
        commit_editor = {
          ["q"] = "Close",
          ["<c-c><c-c>"] = "Submit",
          ["<c-c><c-k>"] = "Abort",
        },
        rebase_editor = {
          ["p"] = "Pick",
          ["r"] = "Reword",
          ["e"] = "Edit",
          ["s"] = "Squash",
          ["f"] = "Fixup",
          ["x"] = "Execute",
          ["d"] = "Drop",
          ["b"] = "Break",
          ["q"] = "Close",
          ["<cr>"] = "OpenCommit",
          ["gk"] = "MoveUp",
          ["gj"] = "MoveDown",
          ["<c-c><c-c>"] = "Submit",
          ["<c-c><c-k>"] = "Abort",
        },
        finder = {
          ["<cr>"] = "Select",
          ["<c-c>"] = "Close",
          ["<esc>"] = "Close",
          ["<c-n>"] = "Next",
          ["<c-p>"] = "Previous",
          ["<down>"] = "Next",
          ["<up>"] = "Previous",
          ["<tab>"] = "MultiselectToggleNext",
          ["<s-tab>"] = "MultiselectTogglePrevious",
          ["<c-j>"] = "NOP",
        },
        popup = {
          ["?"] = "HelpPopup",
          ["A"] = "CherryPickPopup",
          ["D"] = "DiffPopup",
          ["M"] = "RemotePopup",
          ["P"] = "PushPopup",
          ["X"] = "ResetPopup",
          ["Z"] = "StashPopup",
          ["b"] = "BranchPopup",
          ["c"] = "CommitPopup",
          ["f"] = "FetchPopup",
          ["l"] = "LogPopup",
          ["m"] = "MergePopup",
          ["p"] = "PullPopup",
          ["r"] = "RebasePopup",
          ["v"] = "RevertPopup",
        },
        status = {
          ["q"] = "Close",
          ["I"] = "InitRepo",
          ["1"] = "Depth1",
          ["2"] = "Depth2",
          ["3"] = "Depth3",
          ["4"] = "Depth4",
          ["<tab>"] = "Toggle",
          ["x"] = "Discard",
          ["s"] = "Stage",
          ["S"] = "StageUnstaged",
          ["<c-s>"] = "StageAll",
          ["u"] = "Unstage",
          ["U"] = "UnstageStaged",
          ["$"] = "CommandHistory",
          ["#"] = "Console",
          ["<c-r>"] = "RefreshBuffer",
          ["<enter>"] = "GoToFile",
          ["<c-v>"] = "VSplitOpen",
          ["<c-x>"] = "SplitOpen",
          ["<c-t>"] = "TabOpen",
          ["{"] = "GoToPreviousHunkHeader",
          ["}"] = "GoToNextHunkHeader",
        },
      },
    },
  },
  
  -- Diffview for advanced diff/merge operations
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
    },
    opts = {
      diff_binaries = false,
      enhanced_diff_hl = true,
      git_cmd = { "git" },
      use_icons = true,
      show_help_hints = true,
      watch_index = true,
      icons = {
        folder_closed = "",
        folder_open = "",
      },
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
      view = {
        default = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
        },
        file_history = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
      },
      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
          win_opts = {},
        },
      },
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
          win_opts = {},
        },
      },
      commit_log_panel = {
        win_config = {
          win_opts = {},
        },
      },
      default_args = {
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },
      hooks = {},
      keymaps = {
        disable_defaults = false,
        view = {
          { "n", "<tab>", "<cmd>DiffviewToggleFiles<CR>", { desc = "Toggle file panel" } },
          { "n", "gf", "<cmd>DiffviewToggleFiles<CR>", { desc = "Toggle file panel" } },
          { "n", "<leader>e", "<cmd>DiffviewToggleFiles<CR>", { desc = "Toggle file panel" } },
          { "n", "g<C-x>", "<cmd>DiffviewRefresh<CR>", { desc = "Refresh stats" } },
          { "n", "<leader>co", "<cmd>DiffviewConflictChooseOurs<CR>", { desc = "Choose ours (conflict)" } },
          { "n", "<leader>ct", "<cmd>DiffviewConflictChooseTheirs<CR>", { desc = "Choose theirs (conflict)" } },
          { "n", "<leader>cb", "<cmd>DiffviewConflictChooseBoth<CR>", { desc = "Choose both (conflict)" } },
          { "n", "<leader>cB", "<cmd>DiffviewConflictChooseBase<CR>", { desc = "Choose base (conflict)" } },
          { "n", "<leader>cN", "<cmd>DiffviewConflictChooseNone<CR>", { desc = "Choose none (conflict)" } },
        },
        diff1 = {},
        diff2 = {},
        diff3 = {
          { { "n", "x" }, "2do", "<cmd>diffget //2<CR>", { desc = "Obtain from left" } },
          { { "n", "x" }, "3do", "<cmd>diffget //3<CR>", { desc = "Obtain from right" } },
        },
        diff4 = {
          { { "n", "x" }, "1do", "<cmd>diffget //1<CR>", { desc = "Obtain base" } },
          { { "n", "x" }, "2do", "<cmd>diffget //2<CR>", { desc = "Obtain ours" } },
          { { "n", "x" }, "3do", "<cmd>diffget //3<CR>", { desc = "Obtain theirs" } },
        },
        file_panel = {
          { "n", "j", "<cmd>lua require'diffview.actions'.next_entry()<CR>", { desc = "Next file" } },
          { "n", "<down>", "<cmd>lua require'diffview.actions'.next_entry()<CR>", { desc = "Next file" } },
          { "n", "k", "<cmd>lua require'diffview.actions'.prev_entry()<CR>", { desc = "Previous file" } },
          { "n", "<up>", "<cmd>lua require'diffview.actions'.prev_entry()<CR>", { desc = "Previous file" } },
          { "n", "<cr>", "<cmd>lua require'diffview.actions'.select_entry()<CR>", { desc = "Select entry" } },
          { "n", "o", "<cmd>lua require'diffview.actions'.select_entry()<CR>", { desc = "Select entry" } },
          { "n", "<2-LeftMouse>", "<cmd>lua require'diffview.actions'.select_entry()<CR>", { desc = "Select entry" } },
          { "n", "-", "<cmd>lua require'diffview.actions'.toggle_stage_entry()<CR>", { desc = "Toggle stage" } },
          { "n", "S", "<cmd>lua require'diffview.actions'.stage_all()<CR>", { desc = "Stage all" } },
          { "n", "U", "<cmd>lua require'diffview.actions'.unstage_all()<CR>", { desc = "Unstage all" } },
          { "n", "X", "<cmd>lua require'diffview.actions'.restore_entry()<CR>", { desc = "Restore entry" } },
          { "n", "L", "<cmd>lua require'diffview.actions'.open_commit_log()<CR>", { desc = "Open commit log" } },
          { "n", "zo", "<cmd>lua require'diffview.actions'.open_fold()<CR>", { desc = "Open fold" } },
          { "n", "h", "<cmd>lua require'diffview.actions'.close_fold()<CR>", { desc = "Close fold" } },
          { "n", "zc", "<cmd>lua require'diffview.actions'.close_fold()<CR>", { desc = "Close fold" } },
          { "n", "za", "<cmd>lua require'diffview.actions'.toggle_fold()<CR>", { desc = "Toggle fold" } },
          { "n", "zR", "<cmd>lua require'diffview.actions'.open_all_folds()<CR>", { desc = "Open all folds" } },
          { "n", "zM", "<cmd>lua require'diffview.actions'.close_all_folds()<CR>", { desc = "Close all folds" } },
          { "n", "<c-b>", "<cmd>lua require'diffview.actions'.scroll_view(-0.25)<CR>", { desc = "Scroll up" } },
          { "n", "<c-f>", "<cmd>lua require'diffview.actions'.scroll_view(0.25)<CR>", { desc = "Scroll down" } },
          { "n", "<tab>", "<cmd>lua require'diffview.actions'.select_next_entry()<CR>", { desc = "Next file" } },
          { "n", "<s-tab>", "<cmd>lua require'diffview.actions'.select_prev_entry()<CR>", { desc = "Previous file" } },
          { "n", "gf", "<cmd>lua require'diffview.actions'.goto_file()<CR>", { desc = "Go to file" } },
          { "n", "<C-w><C-f>", "<cmd>lua require'diffview.actions'.goto_file_split()<CR>", { desc = "Go to file (split)" } },
          { "n", "<C-w>gf", "<cmd>lua require'diffview.actions'.goto_file_tab()<CR>", { desc = "Go to file (tab)" } },
          { "n", "i", "<cmd>lua require'diffview.actions'.listing_style()<CR>", { desc = "Toggle listing style" } },
          { "n", "f", "<cmd>lua require'diffview.actions'.toggle_flatten_dirs()<CR>", { desc = "Toggle flatten dirs" } },
          { "n", "R", "<cmd>lua require'diffview.actions'.refresh_files()<CR>", { desc = "Refresh" } },
          { "n", "<leader>e", "<cmd>lua require'diffview.actions'.focus_files()<CR>", { desc = "Focus files" } },
          { "n", "<leader>b", "<cmd>lua require'diffview.actions'.toggle_files()<CR>", { desc = "Toggle files" } },
          { "n", "g<C-x>", "<cmd>lua require'diffview.actions'.cycle_layout()<CR>", { desc = "Cycle layout" } },
          { "n", "[x", "<cmd>lua require'diffview.actions'.prev_conflict()<CR>", { desc = "Previous conflict" } },
          { "n", "]x", "<cmd>lua require'diffview.actions'.next_conflict()<CR>", { desc = "Next conflict" } },
        },
        file_history_panel = {
          { "n", "g!", "<cmd>lua require'diffview.actions'.options()<CR>", { desc = "Options" } },
          { "n", "<C-A-d>", "<cmd>lua require'diffview.actions'.open_in_diffview()<CR>", { desc = "Open in diffview" } },
          { "n", "y", "<cmd>lua require'diffview.actions'.copy_hash()<CR>", { desc = "Copy hash" } },
          { "n", "L", "<cmd>lua require'diffview.actions'.open_commit_log()<CR>", { desc = "Open commit log" } },
          { "n", "zR", "<cmd>lua require'diffview.actions'.open_all_folds()<CR>", { desc = "Open all folds" } },
          { "n", "zM", "<cmd>lua require'diffview.actions'.close_all_folds()<CR>", { desc = "Close all folds" } },
          { "n", "j", "<cmd>lua require'diffview.actions'.next_entry()<CR>", { desc = "Next entry" } },
          { "n", "<down>", "<cmd>lua require'diffview.actions'.next_entry()<CR>", { desc = "Next entry" } },
          { "n", "k", "<cmd>lua require'diffview.actions'.prev_entry()<CR>", { desc = "Previous entry" } },
          { "n", "<up>", "<cmd>lua require'diffview.actions'.prev_entry()<CR>", { desc = "Previous entry" } },
          { "n", "<cr>", "<cmd>lua require'diffview.actions'.select_entry()<CR>", { desc = "Select entry" } },
          { "n", "o", "<cmd>lua require'diffview.actions'.select_entry()<CR>", { desc = "Select entry" } },
          { "n", "<2-LeftMouse>", "<cmd>lua require'diffview.actions'.select_entry()<CR>", { desc = "Select entry" } },
          { "n", "<c-b>", "<cmd>lua require'diffview.actions'.scroll_view(-0.25)<CR>", { desc = "Scroll up" } },
          { "n", "<c-f>", "<cmd>lua require'diffview.actions'.scroll_view(0.25)<CR>", { desc = "Scroll down" } },
          { "n", "<tab>", "<cmd>lua require'diffview.actions'.select_next_entry()<CR>", { desc = "Next entry" } },
          { "n", "<s-tab>", "<cmd>lua require'diffview.actions'.select_prev_entry()<CR>", { desc = "Previous entry" } },
          { "n", "gf", "<cmd>lua require'diffview.actions'.goto_file()<CR>", { desc = "Go to file" } },
          { "n", "<C-w><C-f>", "<cmd>lua require'diffview.actions'.goto_file_split()<CR>", { desc = "Go to file (split)" } },
          { "n", "<C-w>gf", "<cmd>lua require'diffview.actions'.goto_file_tab()<CR>", { desc = "Go to file (tab)" } },
          { "n", "<leader>e", "<cmd>lua require'diffview.actions'.focus_files()<CR>", { desc = "Focus files" } },
          { "n", "<leader>b", "<cmd>lua require'diffview.actions'.toggle_files()<CR>", { desc = "Toggle files" } },
          { "n", "g<C-x>", "<cmd>lua require'diffview.actions'.cycle_layout()<CR>", { desc = "Cycle layout" } },
        },
        option_panel = {
          { "n", "<tab>", "<cmd>lua require'diffview.actions'.select_entry()<CR>", { desc = "Select entry" } },
          { "n", "q", "<cmd>lua require'diffview.actions'.close()<CR>", { desc = "Close" } },
        },
      },
    },
  },
}
