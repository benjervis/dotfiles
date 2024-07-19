---@alias RootConfig { label: string, fn: fun(): string}
---@alias RootType "workspace" | "git" | "lsp" | "cwd"

---@type table<RootType, RootConfig>
M = {}

---@param root_object RootConfig
local function make_callable(root_object)
  setmetatable(root_object, { __call = root_object.fn })
  return root_object
end

---@type RootConfig
M.workspace = make_callable({
  label = "Workspace",
  fn = vim.g.workspace_root,
})

---@type RootConfig
M.git = make_callable({
  label = "Git",
  fn = LazyVim.root.git,
})

---@type RootConfig
M.lsp = make_callable({
  label = "LSP",
  fn = function()
    return LazyVim.root.detectors.lsp(0)[1]
  end,
})

---@type RootConfig
M.cwd = make_callable({
  label = "CWD",
  fn = function()
    return LazyVim.root.detectors.cwd()[1]
  end,
})

return M
