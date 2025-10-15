return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true, -- Automatically show suggestions
        debounce = 150, -- Reduce input delay
        keymap = {
          accept = "**", -- Accept Copilot suggestion
        },
        copilot_model = "gpt-4o-copilot",
      },
    })
  end,
}
