local root_selectors = require("config.root_selectors")

local M = {}

---@param root RootType
M.pick_files = function(root)
  local selector = root_selectors[root]
  local cwd = selector()

  return LazyVim.pick("files", {
    cwd = cwd,
    winopts = { title = " Find files - " .. selector.label .. " " },
  })
end

---@param root "workspace"
M.pick_node_modules = function(root)
  local selector = root_selectors[root]

  return LazyVim.pick("files", {
    cwd = vim.fs.joinpath(selector(), "node_modules"),
    winopts = { title = " Find node_modules - " .. selector.label .. " " },
  })
end

---@param root RootType
M.pick_old_files = function(root)
  local selector = root_selectors[root]
  local cwd = selector()

  return LazyVim.pick("oldfiles", {
    cwd = cwd,
    winopts = { title = " Recent files - " .. selector.label .. " " },
  })
end

return M
