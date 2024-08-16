local wk = require("which-key")
local grug = require("grug-far").grug_far

local path_yank = require("config.path-yank")
local roots = require("config.root_selectors")

wk.add({ "<leader>cy", path_yank.copy_path, mode = { "n", "v" }, desc = "Copy current path" })
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

wk.add({
  "<leader>gg",
  function()
    LazyVim.lazygit({ size = { width = 1, height = 0.95 } })
  end,
  desc = "Lazygit (Root Dir)",
})
