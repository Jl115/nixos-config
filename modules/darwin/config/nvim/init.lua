vim.opt.runtimepath:prepend(vim.fn.expand("~/.local/share/lazyvim"))

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
