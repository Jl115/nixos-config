return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
      {
        "ravitemer/mcphub.nvim",
        build = "npm install -g mcp-hub@latest",
        lazy = false,
        config = function()
          require("mcphub").setup({
            auto_toggle_mcp_servers = true,
          })
        end,
      },
    },
    cmd = { "CodeCompanion", "CodeCompanionChat" },
    opts = {
      auto_start = true,
      strategies = {
        chat = {
          adapter = {
            name = "copilot",
            model = "claude-3.7-sonnet",
          },
          on_submit = function(chat)
            if vim.fn.line("$") > 100 then
              chat:apply_tool("mcp.context7")
              chat:apply_tool("mcp.server-memory")
              chat:apply_tool("mcp.server-sequential-thinking")
            end
          end,
        },
      },
    },
    config = function(_, opts)
      local ok, mcp_tools = pcall(require, "mcphub.extensions.codecompanion")
      if ok then
        opts.strategies.chat.tools = {
          mcp = {
            callback = mcp_tools,
            description = "Use MCP tools like context7",
            opts = { requires_approval = true },
          },
        }
      end

      require("codecompanion").setup(opts)
    end,
    lazy = true,
  },
}
