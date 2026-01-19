return {
  "MunifTanjim/nui.nvim",
  "jeffkreeftmeijer/vim-numbertoggle",
  "nvim-tree/nvim-web-devicons",
  "sindrets/diffview.nvim",
  "kevinhwang91/nvim-hlslens",
  "github/copilot.vim",
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-neotest/neotest-jest",
  --   },
  --   config = function()
  --     require("neotest").setup({
  --       adapters = {
  --         require("neotest-jest")({
  --           jestCommand = "yarn test --",
  --         }),
  --       },
  --     })
  --   end,
  -- },
  {
    "petertriho/nvim-scrollbar",
    opts = true,
    init = function()
      require("scrollbar.handlers.search").setup()
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = {
      highlights = {
        PMenuSel = { bg = "#222222" },
      },
    },
  },
  { "tpope/vim-surround", lazy = false },
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_theme = "ocean"
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      {
        "<C-h>",
        "<cmd>TmuxNavigateLeft<CR>",
        desc = "Tmux navigate left",
      },
      {
        "<C-l>",
        "<cmd>TmuxNavigateRight<CR>",
        desc = "Tmux navigate right",
      },
    },
  },
  {
    "folke/which-key.nvim",
    ---@type wk.Opts
    opts = {
      preset = "helix",
      notify = true,
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    opts = {
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        lsp_doc_border = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        prettier = {
          condition = function(_, ctx)
            return string.find(ctx.filename, "node_modules", 1, true) == nil
          end,
        },
        shfmt = {
          prepend_args = { "--indent", "2", "--case-indent", "--binary-next-line" },
        },
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    opts = {
      select = {
        get_config = function(opts)
          local format_item_override = {
            root_selector = function(action_tuple)
              vim.print("Action Tuple", action_tuple)
              return require("config.root_selectors")[action_tuple[2]].label
            end,
          }
          if opts.kind == "root_selector" then
            return {
              format_item_override,
              backend = "nui",
              nui = {
                relative = "editor",
                max_width = 10,
              },
            }
          else
            return {
              format_item_override,
            }
          end
        end,
      },
    },
  },
  {
    "nvim-mini/mini.files",
    opts = {
      mappings = {
        -- Map mini files synchronize to Ctrl-s
        synchronize = "<C-s>",
      },
      windows = {
        -- Maximum number of windows to show side by side
        max_number = math.huge,
        -- Whether to show preview of file/directory under cursor
        preview = true,
        -- Width of focused window
        width_focus = 30,
        -- Width of non-focused window
        width_nofocus = 15,
        -- Width of preview window
        width_preview = 80,
      },
    },
  },
}
