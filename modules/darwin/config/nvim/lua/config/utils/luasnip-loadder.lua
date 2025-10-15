local M = {}

function M.load_vscode_snippets()
  local snippets_dir = vim.fn.stdpath("config") .. "/snippets"

  if vim.fn.isdirectory(snippets_dir) == 0 then
    return
  end

  local files = vim.fn.readdir(snippets_dir)

  print("Loading custom snippets...")
  for _, file_name in ipairs(files) do
    local full_path = snippets_dir .. "/" .. file_name
    require("luasnip.loaders.from_vscode").load_standalone({ path = full_path })
  end
end

return M
