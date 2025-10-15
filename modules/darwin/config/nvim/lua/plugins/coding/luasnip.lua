return {
  "L3MON4D3/LuaSnip",
  event = "VeryLazy",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    require("config.utils.luasnip-loadder").load_vscode_snippets()
  end,
}
