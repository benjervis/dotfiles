-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function is_flowtype()
  ---@diagnostic disable-next-line: undefined-field
  return vim.fn.getline(1):match("//%s*@flow")
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("disable_tsserver_when_flow", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == "tsserver" and is_flowtype() then
      vim.lsp.stop_client(args.data.client_id, true)
    end
  end,
})
