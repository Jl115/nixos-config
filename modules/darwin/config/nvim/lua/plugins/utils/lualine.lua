return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    -- Keep diagnostics and encoding-related info on the right
    opts.sections.lualine_x = {

      {
        function()
          local fortunes = {
            "  sudo make me a sandwich",
            "  Ship it!",
            "  Keep calm and write shell scripts",
            "ﲵ  Hack the planet!",
            "  There is no cloud, just someone else's computer",
            "  Semicolons are optional. Consequences are not.",
            "  Git happens",
            "  Fear the borrow checker",
            "  Console.log the pain away",
            "󰚩  Write code, not excuses",
            "  rm -rf / --no-preserve-root",
            "󱑖  Your code works... on my machine",
            "󰀘  Welcome to the jungle (of dependencies)",
            "  Use the source, Luke",
            "󰈸  They see me scrollin’, they hatin’",
          }
          local buf = vim.api.nvim_get_current_buf()
          if not vim.b._fortune then
            vim.b._fortune = fortunes[math.random(#fortunes)]
          end
          return vim.b._fortune
        end,
      },

      {
        "encoding",
        icon = "",
      },
      {
        "fileformat",
        symbols = {
          unix = "",
          dos = "",
          mac = "",
        },
      },
      { "filetype", icon_only = false },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
        },
      },
      {
        function()
          local mode = vim.fn.mode()
          local icons = {
            n = "🅝",
            i = "🅘",
            v = "🅥",
            V = "🅥",
            c = "🅒",
            R = "🅡",
          }
          return icons[mode] or mode
        end,
      },
    }
  end,
}
