local wk = require("which-key")

local path_yank = require("config.path-yank")

wk.add({ "<leader>cy", path_yank.copy_path, mode = { "n", "v" }, desc = "Copy current path" })
wk.add({ "<leader>cv", ":lua=", desc = "Lua Command" })


wk.add({
  "<leader>gg",
  function()
    LazyVim.lazygit({ size = { width = 1, height = 0.95 } })
  end,
  desc = "Lazygit (Root Dir)",
})
