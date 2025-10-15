local opt = vim.opt

-- general
vim.opt.scrolloff = 15
vim.g.lazyvim_picker = "telescope"
vim.opt.spell = true
vim.opt.spelllang = { "en" }
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
vim.g.custom_cursor_mode = true -- Toggle this setting
vim.g.loaded_netrw = 1
vim.g.flutter_tools_decorations = {}
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.o.textwidth = 120

if vim.g.custom_cursor_mode then
  vim.opt.guicursor = "n-v-c:block-blinkon500,i-ci-ve:ver25-blinkon200,r-cr-o:hor20-blinkon200"
else
  vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20"
end

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
-- opt.hlsearch = false -- disable highlight searching

-- search
opt.iskeyword:append("-") -- Treat hyphenated words as a single word
opt.signcolumn = "yes" -- Always show the sign column

-- folding
opt.foldcolumn = "0" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
  strategy = {
    [""] = "rainbow-delimiters.strategy.global",
    vim = "rainbow-delimiters.strategy.local",
  },
  query = {
    [""] = "rainbow-delimiters",
    lua = "rainbow-blocks",
  },
  priority = {
    [""] = 110,
    lua = 210,
  },
  highlight = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
  },
}
