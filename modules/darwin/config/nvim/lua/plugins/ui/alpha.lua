return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function(_, opts)
    local dashboard = require("alpha.themes.dashboard")

    -- Load ASCII art of the day
    local day = os.date("%A")
    local art_file = vim.fn.stdpath("config") .. "/lua/config/assets/" .. day .. ".txt"
    local art = {}
    local f = io.open(art_file, "r")
    if f then
      for line in f:lines() do
        table.insert(art, line)
      end
      f:close()
    else
      art = { "ASCII waifu missing :(" }
    end

    -- Replace LazyVim's default buttons
    dashboard.section.buttons.val = {
      dashboard.button("f", "📁  Find File", ":Telescope find_files<CR>"),
      dashboard.button("r", "🕘  Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("g", "🔍  Live Grep", ":Telescope live_grep<CR>"),
      dashboard.button("s", "💾  Restore Session", ":lua require('persistence').load()<CR>"),
      dashboard.button("c", "⚙️  Config", ":e $MYVIMRC<CR>"),
      dashboard.button("l", "📜  Lazy", ":Lazy<CR>"),
      dashboard.button("x", "📜  LazyExtras", ":LazyExtras<CR>"),
      dashboard.button("t", "📝  Todo List", ":TodoTelescope<CR>"),
      dashboard.button("q", "⏻  Quit", ":qa<CR>"),
    }

    -- Override full layout
    opts.layout = {
      {
        type = "group",
        val = {
          { type = "text", val = art, opts = { position = "center", hl = "AlphaPicture" } },
          { type = "padding", val = 2 },
          dashboard.section.buttons,
        },
      },
    }

    -- Optional: color styles
    vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#8be9fd", bold = true })
    vim.api.nvim_set_hl(0, "AlphaPicture", { fg = "#B515BB", bold = true })

    return opts
  end,
}
