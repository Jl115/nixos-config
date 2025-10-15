local function check_keymaps()
  local modes = {
    n = "Normal",
    i = "Insert",
    v = "Visual",
  }

  local output = { "────── Active Keybindings ──────" }

  for char, name in pairs(modes) do
    table.insert(output, "") -- spacing
    table.insert(output, string.format("󰘳 %s Mode", name)) -- ﰘ is a Nerd Font icon
    table.insert(output, "------------------------------")

    local keymaps = vim.api.nvim_get_keymap(char)
    if #keymaps == 0 then
      table.insert(output, "  (No custom mappings found)")
    else
      -- Sort the keymaps alphabetically for readability
      table.sort(keymaps, function(a, b)
        return a.lhs < b.lhs
      end)

      for _, map in ipairs(keymaps) do
        -- Try to get a clean representation of the RHS
        local rhs = map.rhs
        if map.callback then
          rhs = "[Lua function]"
        elseif rhs == "" or rhs == "<Nop>" then
          -- Filter out <Nop> mappings unless they have a description
          if not map.desc or map.desc == "" then
            goto continue
          end
          rhs = "(No operation)"
        end

        local line = string.format("  %-25s -> %s", map.lhs, rhs)
        if map.desc and map.desc ~= "" then
          line = string.format("%s (%s)", line, map.desc)
        end
        table.insert(output, line)
        ::continue::
      end
    end
  end

  -- Create a floating window to display the output
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)

  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.7)

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = "minimal",
    border = "rounded",
  })
end

vim.api.nvim_create_user_command("CheckKeys", check_keymaps, {
  desc = "Review active keybindings for Normal, Insert, and Visual modes",
})
