-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- -- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Save buffer
local ui = require("config.utils.ui")
local map = require("config.utils.keymapper").safe_set
local insert_log = require("config.utils.logger").insert_log

map("v", "<leader>pl", insert_log, { desc = "Insert Debug Log", silent = true })
-- Basic Editing & Navigation
map("n", "<C-f>", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<C-b>", "<cmd>Neotree toggle<cr>", { desc = "Toggle File Tree" })
map("n", "<leader>j", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<leader>k", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("n", "<leader>d", '"_d', { desc = "Delete without copying" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Buffer & Window Management
map("n", "<leader>bn", "<cmd>bn<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bp<cr>", { desc = "Previous buffer" })
map("n", "<leader>bd", ui.bufremove, { desc = "Delete buffer" })
map("n", "<leader>ba", "<cmd>%bd|e#<cr>", { desc = "Close all buffers except current" })
map("n", "<leader>vs", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<C-w>m", "<cmd>MaximizerToggle<cr>", { desc = "Toggle maximize split" })

-- Terminal & UI
map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape Terminal Mode" })
map("n", "<leader>tw", "<cmd>set wrap!<cr>", { desc = "Toggle Wrap Mode" })
map("n", "<leader>z", "<cmd>WindowsMaximize<cr>", { desc = "Zoom into split" })

-- LSP & Git
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename Symbol" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find Word" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
map("n", "<leader>ga", "<cmd>Git add . | Git commit<cr>", { desc = "Git Add & Commit" })
map("n", "<leader>gl", "<cmd>Git log<cr>", { desc = "Git Log" })

-- LazyVim Plugin Manager
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "LazyVim" })
map("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason (LSP Manager)" })
map("n", "<leader>pi", "<cmd>Lazy install<cr>", { desc = "Install Plugins" })
map("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Update Plugins" })
map("n", "<leader>ps", "<cmd>Lazy sync<cr>", { desc = "Sync Plugins" })
map("n", "<leader>bs", "<cmd>w<cr>", { desc = "Save Buffer" })

map("n", "<leader>bsh", ":split<CR>", { desc = "Horizontal Split" })
map("n", "<leader>bsv", ":vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>bsc", ":close<CR>", { desc = "Close Split" })

map("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true, desc = "Go to buffer 1" })
map("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true, desc = "Go to buffer 2" })
map("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true, desc = "Go to buffer 3" })
map("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true, desc = "Go to buffer 4" })
map("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true, desc = "Go to buffer 5" })
map("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true, desc = "Go to buffer 6" })
map("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true, desc = "Go to buffer 7" })
map("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true, desc = "Go to buffer 8" })
map("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true, desc = "Go to buffer 9" })

-- Exit insert mode with `ii`
map("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Exit Insert Mode with ii" })
map("n", "zz", "<cmd>ZenMode<CR>", { noremap = true, silent = true, desc = "Enter Zenmode" })
map("v", "zz", "<cmd>ZenMode<CR>", { noremap = true, silent = true, desc = "Escape Zenmode" })

-- Remap Shift+U to redo (Ctrl+R)
map("n", "U", "<C-r>", { desc = "Redo" })

map("i", "<Tab>", "<Tab>", { noremap = true, silent = true })
map({ "i" }, "<C-K>", function()
  ls.expand()
end, { silent = true })
map({ "i", "s" }, "<C-L>", function()
  ls.jump(1)
end, { silent = true })
map({ "i", "s" }, "<C-J>", function()
  ls.jump(-1)
end, { silent = true })

-- DivView
map("n", "<leader>dvo", "<cmd>DiffviewOpen<cr>", { desc = "Toggle DivViewOpen" })
map("n", "<leader>dvc", "<cmd>DiffviewClose<cr>", { desc = "Toggle DivViewClose" })

-- LSP Keymaps
