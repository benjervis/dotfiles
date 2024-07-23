-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.scrolloff = 10
vim.g.lazyvim_picker = "fzf"

vim.g.root_spec = { { ".git", "lua" }, "lsp", "cwd" }

vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        inlayHints = {
          bindingModeHints = { enable = false },
          chainingHints = { enable = false },
          closingBraceHints = { enable = true, minLines = 10 },
          closureCaptureHints = { enable = false },
          closureReturnTypeHints = { enable = "never" },
          discriminantHints = { enable = "never" },
          expressionAdjustmentHints = { enable = "never", hideOutsideUnsafe = true },
          genericParameterHints = {
            const = { enable = false },
            lifetime = { enable = false },
            type = { enable = false },
          },
          implicitDrops = { enable = false },
          lifetimeElisionHints = { enable = "never" },
          parameterHints = { enable = false },
          rangeExclusiveHints = { enable = false },
          typeHints = { enable = false, hideClosureInitialization = false, hideNamedConstructor = false },
        },
      },
    },
  },
}
