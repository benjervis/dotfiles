-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".parcelrc",
  command = ":setfiletype json5",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function(args)
    MiniPairs.map_buf(
      args.buf,
      "i",
      "'",
      { action = "closeopen", pair = "''", neigh_pattern = "[^%a<\\].", register = { cr = false } }
    )
  end,
  desc = "Disable single quote autopairs in Rust",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.fish",
  command = "silent! %s/\\v^(\\n)\\n+/\\1/g",
  desc = "Enforce single linebreaks",
})
