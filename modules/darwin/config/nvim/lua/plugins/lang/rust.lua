return {
  --LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "simrat39/rust-tools.nvim",
    },
    opts = {
      servers = {
        rust_analyzer = {},
      },
      setup = {
        rust_analyzer = function(_, opts)
          opts.capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities)

          local rust_tools = require("rust-tools")

          rust_tools.setup({
            server = vim.tbl_deep_extend("force", opts, {
              on_attach = function(client, buffer)
                -- custom rust-specific keymaps or logic
                vim.keymap.set(
                  "n",
                  "<leader>ca",
                  rust_tools.code_action_group.code_action_group,
                  { buffer = buffer, desc = "Rust Code Action Group" }
                )
                if opts.on_attach then
                  opts.on_attach(client, buffer)
                end
              end,
              settings = {
                ["rust-analyzer"] = {
                  cargo = { allFeatures = true },
                  checkOnSave = {
                    command = "clippy",
                  },
                },
              },
            }),
          })

          return true -- skip default lspconfig setup
        end,
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      dap.adapters.lldb = {
        type = "executable",
        command = "/opt/homebrew/opt/llvm/bin/lldb-vscode", -- adjust as needed
        name = "lldb",
      }
      dap.configurations.rust = {
        {
          name = "Launch Rust",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
    end,
  },
}
