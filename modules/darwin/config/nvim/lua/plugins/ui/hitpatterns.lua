return {
  "nvim-mini/mini.hipatterns",
  event = "BufReadPost",
  lazy = false,
  opts = function()
    local hipatterns = require("mini.hipatterns")
    return {
      highlighters = {
        -- Highlight hex colors like #ff8800
        hex_color = hipatterns.gen_highlighter.hex_color(),
        -- Highlight TODO, FIXME, etc.
      },
    }
  end,
}
