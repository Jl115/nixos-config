return {
  {
    "neovim/nvim-lspconfig",
    -- Optional: Setup for better LSP integration with Neovim
    opts = {
      servers = {
        clangd = {
          cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            local util = lspconfig.util
            return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "cpp" })
    end,
  },

  {
    "mfussenegger/nvim-dap",
    ft = { "c", "cpp" },
    config = function()
      local dap = require("dap")
      dap.adapters.lldb = {
        type = "executable",
        command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
        name = "lldb",
      }
      dap.configurations.c = {
        {
          name = "Launch C",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.cpp = dap.configurations.c
    end,
  },
}
