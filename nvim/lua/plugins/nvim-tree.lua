local root = require("config.root_selectors")

return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        hijack_cursor = true,
        disable_netrw = true,
        renderer = {
          special_files = {
            "package.json",
          },
        },
        update_focused_file = {
          enable = true,
          update_root = {
            enable = true,
          },
        },
        git = {
          enable = false,
        },
      })
    end,
    keys = {
      {
        "<leader>e",
        function()
          require("nvim-tree.api").tree.toggle({ path = root.git() })
        end,
        desc = "Open file tree (nvim-tree)",
      },
    },
  },
}
