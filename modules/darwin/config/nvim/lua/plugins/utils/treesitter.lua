return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "javascript",
      "typescript",
      "dart",
      "bash",
      "markdown",
      -- You can keep additional languages from your existing config if needed:
      "tsx",
      "json",
      "jsonc",
      "java",
      "yaml",
      "html",
      "gomod",
      "css",
      "cpp",
      "scss",
      "regex",
      "query",
      "vue",
      "dockerfile",
      "python",
      "rust",
      "toml",
      "go",
      "graphql",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true, -- Highlight also non-bracket delimiters
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  },
  -- Make sure to add dependencies for textobjects
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "HiPhish/rainbow-delimiters.nvim",
  },
}
