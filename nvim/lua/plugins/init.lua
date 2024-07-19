local wk = require("which-key")
return {
  "MunifTanjim/nui.nvim",
  "jeffkreeftmeijer/vim-numbertoggle",
  "nvim-tree/nvim-web-devicons",
  "sindrets/diffview.nvim",
  {
    "nvim-spectre",
    opts = { default = { replace = { cmd = "oxi" } } },
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
    "AndrewRadev/sideways.vim",
    keys = function()
      wk.add({
        {
          "<leader>S",
          icon = "→",
          group = "GSideways",
        },
        {
          {
            "<leader>Sh",
            "<cmd>SidewaysLeft<CR>",
            desc = "Sideways left",
          },
          {
            "<leader>Sl",
            "<cmd>SidewaysRight<CR>",
            desc = "Sideways right",
          },
          {
            "<leader>Si",
            "<Plug>SidewaysArgumentInsertBefore",
            desc = "Sideways insert argument before",
          },
          {
            "<leader>Sa",
            "<Plug>SidewaysArgumentAppendAfter",
            desc = "Sideways append argument after",
          },
          {
            "<leader>SI",
            "<Plug>SidewaysArgumentInsertFirst",
            desc = "Sideways insert argument first",
          },
          {
            "<leader>SA",
            "<Plug>SidewaysArgumentAppendLast",
            desc = "Sideways append argument last",
          },
          {
            "aa",
            "<Plug>SidewaysArgumentTextobjA",
            mode = { "o", "x" },
          },
          {
            "ia",
            "<Plug>SidewaysArgumentTextobjI",
            mode = { "o", "x" },
          },
        },
      })
    end,
  },

  {
    "ms-jpq/chadtree",
    branch = "chad",
    build = "python3 -m chadtree deps",
    init = function()
      vim.api.nvim_set_var("chadtree_settings", {
        ["theme.text_colour_set"] = "nerdtree_syntax_dark",
        view = {
          width = 25,
          window_options = {
            number = true,
          },
        },
      })
    end,
    keys = {
      { "<leader>e", "<cmd>CHADopen --version-ctl<CR>", desc = "Open file tree" },
    },
  },
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
}
