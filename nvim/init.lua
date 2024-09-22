-- bootstrap lazy.nvim, LazyVim and your plugins
-- Disable netrw so that nvim-tree can run smoother
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")

vim.cmd("colorscheme onedark_dark")
