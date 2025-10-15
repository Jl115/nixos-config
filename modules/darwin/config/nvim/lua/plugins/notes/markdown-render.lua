return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = true,
  opts = {
    bullet = {
      enabled = true,
    },
    checkbox = {
      enabled = true,
      position = "inline",
      unchecked = {
        -- Added more padding to the icon for a bigger visual feel
        icon = "  ",
        highlight = "RenderMarkdownUnchecked",
        scope_highlight = nil,
      },
      checked = {
        -- Added more padding to the icon
        icon = "  ",
        highlight = "RenderMarkdownChecked",
        scope_highlight = nil,
      },
    },
    html = {
      enabled = true,
      comment = {
        conceal = false,
      },
    },
    link = {
      image = vim.g.neovim_mode == "skitty" and "" or "󰥶 ",
      custom = {
        youtu = { pattern = "youtu%.be", icon = "󰗃 " },
      },
    },
    heading = {
      sign = false,
      -- Added more padding to each heading icon
      icons = { " 󰉫 ", " 󰉬 ", " 󰉭 ", " 󰉮 ", " 󰉯 ", " 󰉰 " },
      backgrounds = {
        "Headline1Bg",
        "Headline2Bg",
        "Headline3Bg",
        "Headline4Bg",
        "Headline5Bg",
        "Headline6Bg",
      },
      foregrounds = {
        "Headline1Fg",
        "Headline2Fg",
        "Headline3Fg",
        "Headline4Fg",
        "Headline5Fg",
        "Headline6Fg",
      },
    },

    -- ======================================================= --
    -- NEW SECTIONS ADDED BELOW
    -- ======================================================= --

    -- New section for rendering fenced code blocks
    code_block = {
      enabled = true,
      icon = "󰅪",
      icon_highlight = "RenderMarkdownCodeBlockIcon",
      lang = true,
      lang_highlight = "RenderMarkdownCodeBlockLang",
    },

    -- New section for rendering blockquotes
    blockquote = {
      enabled = true,
      bar = "┃", -- A thin vertical bar
      bar_highlight = "RenderMarkdownBlockquoteBar",
    },

    -- New section for customizing horizontal rules
    horizontal_rule = {
      enabled = true,
      char = "─", -- A line character
      highlight = "RenderMarkdownHorizontalRule",
    },
  },
}
