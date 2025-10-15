return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  enabled = true,
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" },

  opts = {
    snippets = {
      expand = function(snippet, _)
        return LazyVim.cmp.expand(snippet)
      end,
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },
    sources = {
      default = {
        "snippets",
        "lsp",
        "path",
        "buffer",
      },
    },
    cmdline = {
      enabled = true,
      completion = {
        ghost_text = {
          enabled = true,
        },
        menu = {
          auto_show = true,
        },
      },
    },
    keymap = {
      preset = "enter", -- disables default Tab/CR
      ["<Tab>"] = false, -- explicitly disables Tab
      ["<S-Tab>"] = false, -- if needed
      ["<C-y>"] = { "select_and_accept" },
    },
  },
}
