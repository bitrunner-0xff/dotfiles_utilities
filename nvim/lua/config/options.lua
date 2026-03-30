-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.guicursor = ""
opt.termguicolors = true

-- APPEARANCE -----------------------------------------------------------------
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.splitbelow = true
opt.splitright = true
opt.wrap = false

-- TAB INDENT -----------------------------------------------------------------
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- MISC ----------------------------------------------------------------------
opt.swapfile = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.backup = false
opt.writebackup = false

opt.completeopt = { "menu", "menuone", "noselect" }
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
-- Highlight matching brace
opt.showmatch = true
opt.complete = "kspell" -- TODO: test if it works at all
-- opt.autocomplete = true
opt.spelllang = { "en" }
opt.spellsuggest = { "best", 9 }
opt.wildignorecase = true
opt.confirm = true
opt.autowriteall = true
opt.list = true
opt.listchars = { tab = [[│ ]], trail = "•", extends = "»", precedes = "«" }
opt.foldenable = false

-- SEARCH ---------------------------------------------------------------------
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.scrolloff = 8
opt.signcolumn = "yes"

opt.updatetime = 100
opt.timeoutlen = 500

opt.colorcolumn = "80"
opt.background = "dark"

opt.clipboard = "unnamedplus" -- use system clipboard
