return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    -- Get a copy of the default configuration for eslint_d
    local eslint_d_config = lint.linters.eslint_d

    -- Create our new custom linter by merging our desired arguments
    -- into the default configuration. This inherits the working root_dir, parser, etc.
    lint.linters.eslint_d_custom = vim.tbl_deep_extend("force", eslint_d_config, {
      -- We ONLY need to override the 'args' to add our special flag.
      args = {
        "--stdin",
        "--stdin-filename",
        "{filename}",
        "--resolve-plugins-relative-to",
        "{root}",
      },
    })
  end,
  opts = {
    linters_by_ft = {
      -- Use our new, safely extended definition
      javascript = { "eslint_d_custom" },
      typescript = { "eslint_d_custom" },
      vue = { "eslint_d_custom" },
      go = { "golangcilint" },
    },
  },
}
