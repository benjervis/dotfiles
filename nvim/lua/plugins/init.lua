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
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      opts.sources = vim.tbl_map(
        ---@param source cmp.SourceConfig
        function(source)
          if source.name ~= "nvim_lsp" then
            return source
          end

          ---@param entry cmp.Entry
          source.entry_filter = function(entry, _)
            -- vim.print("entry", entry)
            return entry:get_kind() ~= cmp.lsp.CompletionItemKind.Snippet
          end

          return source
        end,
        ---@param source cmp.SourceConfig
        vim.tbl_filter(function(source)
          return source.name ~= "snippets"
        end, opts.sources)
      )

      opts.enabled = function()
        -- disable completion in comments
        local context = require("cmp.config.context")
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == "c" then
          return true
        else
          return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end
      end

      opts.window = {
        completion = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = -3,
          side_padding = 0,
        },
        documentation = cmp.config.window.bordered(),
      }
    end,
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
        long_message_to_split = true, -- long messages will be sent to a split
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
              return require("config.root_selectors").roots[action_tuple[2]].label
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
