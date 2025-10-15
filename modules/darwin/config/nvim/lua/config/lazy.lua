local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local function flatten(t)
  local result = {}
  for _, v in ipairs(t) do
    if type(v) == "table" and vim.islist(v) then
      vim.list_extend(result, flatten(v))
    else
      table.insert(result, v)
    end
  end
  return result
end

local function get_plugin_specs(dir)
  local path = vim.fn.stdpath("config") .. "/lua/" .. dir
  local plugin_files = vim.fn.globpath(path, "**/*.lua", false, true)
  local specs = {}

  for _, file in ipairs(plugin_files) do
    local module = file:gsub(vim.fn.stdpath("config") .. "/lua/", ""):gsub("%.lua$", ""):gsub("/", ".")

    if not module:match("%.init$") then
      local status, plugin_spec = pcall(require, module)
      if status then
        if type(plugin_spec) == "table" then
          if vim.islist(plugin_spec) then
            vim.list_extend(specs, flatten(plugin_spec))
          else
            table.insert(specs, plugin_spec)
          end
        else
          vim.notify("Plugin spec is not a table: " .. module, vim.log.levels.ERROR)
        end
      else
        vim.notify("Failed to load plugin spec: " .. module .. ": " .. plugin_spec, vim.log.levels.ERROR)
      end
    end
  end

  return specs
end

local plugin_specs = get_plugin_specs("plugins")

require("lazy").setup({
  spec = {
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {},
    },
    -- Add all plugin specs individually
    unpack(plugin_specs),
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "catpuccin" } },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
