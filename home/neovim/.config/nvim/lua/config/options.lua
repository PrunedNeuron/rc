-- ============================================================================
-- Core Neovim Options - Modern Defaults (2025)
-- ============================================================================

local opt = vim.opt

-- ============================================================================
-- EDITOR BEHAVIOR
-- ============================================================================

-- Line numbers: Absolute for clarity, no relative (reduces cognitive load)
opt.number = true
opt.relativenumber = false

-- Indentation: 2 spaces (community standard for Lua/web dev)
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Line wrapping
opt.wrap = false -- Disable by default; enable per filetype
opt.linebreak = true -- Break at word boundaries when wrap is on
opt.breakindent = true -- Preserve indent on wrapped lines

-- Scrolling: Maintain context around cursor
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Line movement: Arrows can cross line boundaries
opt.whichwrap:append("<,>,[,]")

-- ============================================================================
-- SEARCH & REPLACE
-- ============================================================================

opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true -- Override ignorecase if uppercase present
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Show matches as you type

-- ============================================================================
-- UI & APPEARANCE
-- ============================================================================

-- Colors
opt.termguicolors = true -- 24-bit RGB color support
opt.background = "dark"

-- Command line
opt.cmdheight = 1 -- Single line command area
opt.showcmd = true
opt.showmode = false -- Hide mode (shown in statusline)

-- Sign column: Always show to prevent layout shifts
opt.signcolumn = "yes"

-- Cursor line: Highlight current line
opt.cursorline = true

-- Split windows: More intuitive directions
opt.splitbelow = true
opt.splitright = true

-- Status and tab lines
opt.laststatus = 3 -- Global statusline
opt.showtabline = 2 -- Always show tabline

-- ============================================================================
-- FILES & BACKUP
-- ============================================================================

opt.swapfile = false -- Disable swap files (modern editors don't need them)
opt.backup = false
opt.writebackup = false

-- Undo: Persistent across sessions
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- File encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Auto-reload files changed outside Neovim
opt.autoread = true

-- ============================================================================
-- COMPLETION & POPUP
-- ============================================================================

-- Completion menu height
opt.pumheight = 15

-- Completion behavior
opt.completeopt = "menu,menuone,noselect"

-- Wildmenu (command completion)
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"

-- ============================================================================
-- PERFORMANCE
-- ============================================================================

-- Update time: Faster CursorHold events (ms)
opt.updatetime = 250

-- Timeout for key sequences
opt.timeoutlen = 300

-- Redraw: Only when needed
opt.lazyredraw = false -- Modern Neovim handles this well

-- Max syntax column for highlighting (performance)
opt.synmaxcol = 300

-- ============================================================================
-- MISCELLANEOUS
-- ============================================================================

-- Mouse support
opt.mouse = "a"

-- Clipboard: Use system clipboard
opt.clipboard = "unnamedplus"

-- Concealment level (for markdown, etc.)
opt.conceallevel = 2

-- Fill characters (FIXED: Use simple ASCII/single-byte characters)
opt.fillchars = {
  fold = " ",
  foldopen = "▼",  -- Simple Unicode: U+25BC
  foldclose = "▶", -- Simple Unicode: U+25B6
  foldsep = " ",
  diff = "╱",      -- U+2571
  eob = " ",
}

-- List characters (for :set list)
opt.list = true
opt.listchars = {
  tab = "→ ",
  trail = "·",
  nbsp = "␣",
  extends = "⟩",
  precedes = "⟨",
}

-- Spell checking: Disabled by default, enable per filetype
opt.spell = false
opt.spelllang = "en_us"

-- Session options
opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
  "help",
  "globals",
  "skiprtp",
  "folds",
}

-- Format options
opt.formatoptions = "jcroqlnt"

-- ============================================================================
-- SECURITY
-- ============================================================================

-- Disable modeline (security risk)
opt.modeline = false
opt.modelines = 0
