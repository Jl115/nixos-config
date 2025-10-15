local M = {}
function M.insert_log()
  vim.cmd('normal! "vy')
  local s = vim.fn.getreg("v")
  if s == "" then
    return vim.notify("Nothing selected", vim.log.levels.ERROR)
  end

  local ft = vim.bo.filetype
  local templates = {
    javascript = [[console.log('\x1b[33m%%s\x1b[0m', '%s--------------------', %s);]],
    typescript = [[console.log('\x1b[33m%%s\x1b[0m', '%s--------------------', %s);]],
    typescriptreact = [[console.log('\x1b[33m%%s\x1b[0m', '%s--------------------', %s);]],
    vue = [[console.log('\x1b[33m%%s\x1b[0m', '%s--------------------', %s);]],
    dart = [[print(''\x1b[33m%%s\x1b[0m'','%s--------------------${%s}');]],
    python = [[print("\033[33m%s--------------------\033[0m", %s)]],
    lua = [[print('\27[33m%s--------------------\27[0m', %s)]],
  }

  local tpl = templates[ft]
  if not tpl then
    return vim.notify("Unsupported filetype: " .. ft, vim.log.levels.WARN)
  end
  vim.api.nvim_put({ string.format(tpl, s, s) }, "l", true, true)
end

return M
