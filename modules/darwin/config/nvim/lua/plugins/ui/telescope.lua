return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        local ok, _ = pcall(require("telescope").load_extension, "fzf")
        if not ok then
          vim.notify("Telescope FZF extension failed to load", vim.log.levels.ERROR)
        end
      end,
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
      prompt_prefix = " ",
      selection_caret = " ",
    },
    pickers = {
      find_files = {
        hidden = true,
      },
    },
  },
}
