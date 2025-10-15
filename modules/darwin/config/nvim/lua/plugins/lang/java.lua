
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mfussenegger/nvim-jdtls",
    },
    ft = { "java" },
    opts = {
      servers = {
        jdtls = {},
      },
      setup = {
        jdtls = function(_, opts)
          opts.capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities)
          local jdtls = require("jdtls")
          local util = require("lspconfig.util")

          local root_dir = util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle")(vim.fn.expand("%:p"))

          if root_dir == nil then
            return
          end

          local project_name = vim.fn.fnamemodify(root_dir, ":t")
          local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

          local jdtls_cmd = {
            "jdtls",
            "--jvm-arg=-javaagent:" .. vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar",
          }

          local config = vim.tbl_deep_extend("force", opts, {
            cmd = jdtls_cmd,
            root_dir = root_dir,
            init_options = {
              workspace = workspace_dir,
            },
            settings = {
              java = {
                signatureHelp = { enabled = true },
                format = { enabled = true },
                contentProvider = { preferred = "fernflower" },
                eclipse = {
                  downloadSources = true,
                },
                configuration = {
                  updateBuildConfiguration = "interactive",
                  runtimes = {
                    {
                      name = "JavaSE-24",
                      path = "/Library/Java/JavaVirtualMachines/temurin-24.jdk/Contents/Home",
                    },
                  },
                },
                maven = {
                  downloadSources = true,
                },
                references = {
                  includeDecompiledSources = true,
                },
                implementationsCodeLens = {
                  enabled = true,
                },
                referencesCodeLens = {
                  enabled = true,
                },
              },
            },
            
          })

          -- Attach DAP (debugging) support
          config.on_attach = function(_, _)
            require("jdtls").setup_dap({ hotcodereplace = "auto" })
            require("jdtls.dap").setup_dap_main_class_configs()
          end

          jdtls.start_or_attach(config)
          if not vim.api.nvim_buf_get_name(0):match("%.java$") then
            return
          end
          return true
        end,
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    ft = "java",
    config = function()
      local dap = require("dap")

      -- Java adapter (must be provided)
      dap.adapters.java = function(callback)
        callback({
          type = "server",
          host = "127.0.0.1",
          port = 5005,
        })
      end

      dap.configurations.java = {
        {
          type = "java",
          request = "launch",
          name = "Launch Java Main",
          mainClass = function()
            return vim.fn.input("Main class > ")
          end,
          projectName = function()
            return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          end,
        },
      }
    end,
  },
}
