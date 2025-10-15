return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- TypeScript and JavaScript Language Server
        ts_ls = {
          filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        },

        -- Vue Language Server
        vue_ls = {
          filetypes = {
            "vue",
          },
          init_options = {
            vue = { hybridMode = false },
            typescript = {
              tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
            },
          },
          on_attach = function(client)
            -- This disables diagnostics from Volar
            client.handlers["textDocument/publishDiagnostics"] = function() end
          end,
        },
      },
    },
  },

  -- DAP
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      local dap_vscode_js = require("dap-vscode-js")

      dap_vscode_js.setup({
        node_path = "node",
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
        adapters = {
          "pwa-node",
          "pwa-chrome",
          "pwa-msedge",
          "node-terminal",
          "pwa-extensionHost",
        },
        debugger_cmd = { "js-debug-adapter" },
        log_file_path = vim.fn.stdpath("cache") .. "/dap-vscode-js.log",
        log_file_level = os.getenv("DEBUG") and 1 or 2, -- DEBUG or INFO
        log_console_level = os.getenv("DEBUG") and 1 or 2, -- DEBUG or INFO
      })

      for _, language in ipairs({ "typescript", "javascript", "vue" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
