M = {}

---@param args string[]
---@param opts? {trim: boolean}
M.run_shell_cmd = function(args, opts)
  local cmd_result = vim.system(args, { text = true }):wait()
  local result = cmd_result.stdout

  opts = opts or { trim = true }

  if result ~= nil and opts.trim then
    result = result:gsub("%s*(%S*)%s*", "%1")
  end

  return result
end

return M
