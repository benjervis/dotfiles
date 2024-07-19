local root_selectors = require("config.root_selectors")

local M = {}

---@param opts {command: string, title: string, cwd_suffix?: string}
local function construct_picker(opts)
  return function(root)
    return function()
      local selector = root_selectors[root]
      LazyVim.pick(opts.command, {
        cwd = vim.fs.joinpath(selector(), opts.cwd_suffix),
        winopts = { title = " " .. opts.title .. " - " .. selector.label .. " " },
      })()
    end
  end
end

---@type fun(root: RootType)
M.pick_files = construct_picker({ command = "files", title = "Find files" })

---@type fun(root: "workspace")
M.pick_node_modules = construct_picker({ command = "files", title = "Find node_modules", cwd_suffix = "node_modules" })

---@type fun(root: RootType)
M.pick_old_files = construct_picker({ command = "oldfiles", title = "Recent files" })

---@type fun(root: RootType)
M.pick_live_grep = construct_picker({ command = "live_grep", title = "Live Grep" })

return M
