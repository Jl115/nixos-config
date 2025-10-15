return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Not strictly required, but recommended
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        group_empty_dirs = true,
        auto_expand_single_child = true,
        auto_collapse = true,
        hide_by_name = {
          "node_modules",
        },
        never_show = {
          ".DS_Store",
          "node_modules",
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = true, -- Enables live updates
      cwd_target = {
        sidebar = "tab", -- use cwd of current tab (not the global one)
        current = "window", -- cwd updates with buffer's window
      },
    },
    source_selector = {
      winbar = true,
      statusline = true,
    },
    window = {
      position = "left", -- instead of "right"
      close_on_open = true,
      width = 60,
      -- ADD THIS MAPPINGS TABLE TO SWAP THE KEYS
      mappings = {
        ["/"] = "filter_on_submit", -- Give '/' the old 'f' command
        ["f"] = "fuzzy_finder", -- Give 'f' the old '/' command
      },
    },
    popup_border_style = "rounded",
    default_component_configs = {
      indent = {
        with_expanders = true,
      },
    },
  },
}
