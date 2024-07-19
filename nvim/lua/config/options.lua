-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.scrolloff = 10
vim.g.lazyvim_picker = "fzf"

vim.g.root_spec = { { ".git", "lua" }, "lsp", "cwd" }

