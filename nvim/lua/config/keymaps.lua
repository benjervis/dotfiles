-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>cv", ":lua=")
vim.keymap.set("n", "<leader>gg", function()
  LazyVim.lazygit({ cwd = LazyVim.root.git(), size = { width = 1, height = 0.95 } })
end, { desc = "Lazygit (Root Dir)" })
