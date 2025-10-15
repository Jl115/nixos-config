return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = { -- Add this opts table
      integrations = {
        bufferline = true, -- This is the line that fixes the issue
        -- You can add other integrations here as well
        treesitter = true,
        cmp = true,
        gitsigns = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
