-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- load autocmgs for lsps
-- require("config.lsp-autocmds")
require("config.utils.healthcmds")

local orig_buf_set_extmark = vim.api.nvim_buf_set_extmark
vim.api.nvim_buf_set_extmark = function(buf, ns, row, col, opts)
  local ok, ret = pcall(orig_buf_set_extmark, buf, ns, row, col, opts)
  if not ok then
    return nil
  end
  return ret
end
-- Store original inlay hint function
local lsp_inlay_hint = vim.lsp.inlay_hint

-- Create autocommand group for inlay hints
local inlay_hints_group = vim.api.nvim_create_augroup("InlayHintsToggle", { clear = true })

-- Toggle function for inlay hints
local function toggle_inlay_hints(enable)
  if enable then
    local safe_inlay_hint = {}
    setmetatable(safe_inlay_hint, {
      __call = function(_, ...)
        local ok, ret = pcall(lsp_inlay_hint, ...)
        return ret
      end,
      __index = lsp_inlay_hint,
    })
    vim.lsp.inlay_hint = safe_inlay_hint
  else
    local noop = {}
    setmetatable(noop, {
      __call = function() end,
      __index = lsp_inlay_hint,
    })
    vim.lsp.inlay_hint = noop
  end
end

-- Autocommands for text changes

local debounce_timer
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  group = inlay_hints_group,
  callback = function()
    if debounce_timer then
      debounce_timer:stop()
    end
    toggle_inlay_hints(false)
    debounce_timer = vim.defer_fn(function()
      toggle_inlay_hints(true)
    end, 200) -- Increase delay to reduce flickering
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = inlay_hints_group,
  callback = function()
    toggle_inlay_hints(true)
  end,
})

local last_saved_buf = nil

local function autosave_buf(event)
  local buf = event.buf
  if buf == last_saved_buf then
    return
  end

  if
    vim.bo[buf].buftype == ""
    and vim.bo[buf].modifiable
    and vim.bo[buf].buflisted
    and vim.api.nvim_buf_get_name(buf) ~= ""
  then
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! write")
    end)
    last_saved_buf = buf
  end
end

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
  callback = autosave_buf,
})
