local wk = require("which-key")
local grug = require("grug-far").grug_far

local path_yank = require("config.path_yank")
local roots = require("config.root_selectors")

wk.add({ "<leader>cy", group = "Copy file path" })
wk.add({ "<leader>cyy", path_yank.copy_local_path, mode = { "n", "v" }, desc = "Copy current path (relative)" })
wk.add({ "<leader>cya", path_yank.copy_absolute_local_path, mode = { "n", "v" }, desc = "Copy current path (absolute)" })
wk.add({ "<leader>cyr", path_yank.copy_remote_path, mode = { "n", "v" }, desc = "Copy current path (as url)" })
wk.add({
  "<leader>cym",
  function()
    path_yank.copy_remote_path(true)
  end,
  mode = { "n", "v" },
  desc = "Copy current path without branch (as url)",
})

wk.add({ "<leader>cv", ":lua=", desc = "Lua Command" })

wk.add({ "<leader>j", group = "Find and replace" })
wk.add({
  "<leader>jr",
  function()
    grug()
  end,
  desc = "Find and replace",
})
wk.add({
  "<leader>jR",
  function()
    grug({ prefills = { paths = vim.fn.expand("%") } })
  end,
  desc = "Find and replace (file)",
})
wk.add({
  "<leader>jw",
  function()
    grug({ prefills = { paths = roots.workspace() } })
  end,
  desc = "Find and replace (workspace)",
})
wk.add({
  "<leader>jp",
  function()
    grug({ prefills = { paths = roots.package() } })
  end,
  desc = "Find and replace (package)",
})
