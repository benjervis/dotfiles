-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("telescope").load_extension("fzf")

vim.cmd("colorscheme onedark_dark")
