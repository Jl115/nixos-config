return {
  "stevearc/conform.nvim",

  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      json = { "prettierd" },
      markdown = { "prettierd" },
      java = { "google-java-format" },
      dart = { "dart_format" },
      css = { "prettierd" },
      html = { "prettierd" },
      vue = { "prettierd" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      python = { "ruff", "ruff_organize_imports", "ruff_format" },
    },

    formatters = {
      dart_format = {
        command = "fvm",
        args = { "dart", "format", "$FILENAME" },
        stdin = false,
      },
    },
  },
}
