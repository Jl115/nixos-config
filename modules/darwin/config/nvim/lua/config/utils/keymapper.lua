local M = {}

--- A safe wrapper for vim.keymap.set that checks for conflicting global keymaps.
--- @param mode string | table: The mode(s) for the keymap (e.g., 'n', 'v', 'i', or {'n', 'i'}).
--- @param lhs string: The key sequence to map (e.g., '<leader>ff').
--- @param rhs string | function: The command or Lua function to execute.
--- @param opts table | nil: Optional parameters (e.g., { noremap = true, silent = true, desc = "Description" }).
function M.safe_set(mode, lhs, rhs, opts)
  opts = opts or {}

  -- This block safely handles both string ('nv') and table ({'n', 'v'}) modes.
  local modes_to_check = {}
  if type(mode) == "table" then
    modes_to_check = mode
  else -- Assumes it's a string
    for m_char in string.gmatch(mode, ".") do
      table.insert(modes_to_check, m_char)
    end
  end

  -- Iterate through each mode from the prepared list.
  for _, m in ipairs(modes_to_check) do
    if not opts.buffer then
      local existing_map = vim.api.nvim_get_keymap(m)[lhs]
      if existing_map and not existing_map.buffer then
        local msg = string.format(
          "Conflict: Key '%s' in mode '%s' is already mapped to '%s'. Overwriting.",
          lhs,
          m,
          existing_map.rhs or "[LUA]"
        )
        vim.notify(msg, vim.log.levels.WARN, { title = "Keymap Conflict" })
      end
    end
  end

  -- Proceed to set the keymap (vim.keymap.set itself handles both types)
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
