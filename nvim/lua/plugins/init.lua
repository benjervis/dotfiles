return {
  "jeffkreeftmeijer/vim-numbertoggle",
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
  { "junegunn/fzf", build = "./install --all --xdg --no-bash --no-zsh" },
  { "junegunn/fzf.vim" },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><space>", LazyVim.pick("files"), desc = "Find files - Git" },
      {
        "<leader>ff",
        function()
          LazyVim.pick("files", { cwd = LazyVim.root.detectors.lsp(0)[1] })()
        end,
        desc = "Find files - LSP",
      },
      { "<leader>fF", LazyVim.pick("files", { cwd = LazyVim.root.cwd() }), desc = "Find files - CWD" },
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = LazyVim.root.git() }), desc = "Recent files" },
      {
        "<leader>fn",
        function()
          LazyVim.pick("files", { cwd = vim.fs.joinpath(vim.g.workspace_root(), "node_modules") })()
        end,
        desc = "Find node_modules",
      },
    },
    opts = { "fzf-native" },
    config = function()
      local actions = require("fzf-lua.actions")
      return {
        grep = {
          actions = {
            ["ctrl+r"] = { actions.toggle_ignore },
            ["ctrl+h"] = { actions.toggle_hidden },
          },
        },
        files = {
          actions = {
            ["ctrl+h"] = { actions.toggle_hidden },
          },
        },
      }
    end,
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
    keys = {
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
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      { "<leader>fR", LazyVim.pick("oldfiles"), desc = "Recent (all)" },
      {
        "<leader>fj",
        function()
          LazyVim.pick("find_files", { search_dirs = { "build-tools", "dev-tooling" } })
        end,
        desc = "Find Jira tools",
      },
      {
        "<leader>fp",
        LazyVim.pick("find_files", {
          cwd = LazyVim.root.git(),
          search_file = "package.json",
        }),
        desc = "Find packages (git-files)",
      },
      {
        "<leader>fP",
        LazyVim.pick("find_files", { search_file = "package.json" }),
        desc = "Find packages",
      },
      {
        "<leader>fn",
        LazyVim.pick("find_files", {
          no_ignore = true,
          search_dirs = { "node_modules" },
          search_file = "package.json",
        }),
        desc = "Find node_module",
      },
      {
        "<leader>fh",
        LazyVim.pick("find_files", {
          search_dirs = { vim.fn.expand("%:p:h") },
          path_display = { "smart" },
        }),
        desc = "Find files sibling or descendant to current",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
    keys = {
      {
        "<leader>E",
        "<cmd>Neotree %:p:h<CR>",
        desc = "Open file explorer (current dir)",
      },
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
    "roobert/search-replace.nvim",
    config = function()
      require("search-replace").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>S"] = { name = "+Sideways" },
      },
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
}
