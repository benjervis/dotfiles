local fzf_lua = require("fzf-lua")
local actions = require("fzf-lua.actions")
local native_profile = require("fzf-lua.profiles.fzf-native")
local pickers = require("config.pickers")

return {
  { "junegunn/fzf", build = "./install --all --xdg --no-bash --no-zsh" },
  { "junegunn/fzf.vim" },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><space>", pickers.pick_files("git"), desc = "Find files - Repo" },
      { "<leader>ff", pickers.pick_files("workspace"), desc = "Find files - Workspace" },
      { "<leader>fl", pickers.pick_files("package"), desc = "Find files - Package" },
      { "<leader>fr", pickers.pick_old_files("git"), desc = "Recent files - Repo" },
      { "<leader>fn", pickers.pick_node_modules("workspace"), desc = "Find node_modules" },
      { "<leader>sg", pickers.pick_live_grep("git"), desc = "Grep - Repo" },
      { "<leader>sG", pickers.pick_live_grep("workspace"), desc = "Grep - Workspace" },
      { "<leader>sP", pickers.pick_live_grep("package"), desc = "Grep - Package" },
      {
        "<leader>fp",
        function()
          local cmd_string = string.format(
            'rg \z
            \'"name": "(.+)",\' \z
            -g "package.json" \z
            -r \'$1\' \z
            %s \z
            --no-heading \z
            --no-line-number \z
            --trim \z
            --max-count=1',
            LazyVim.root.git()
          )

          fzf_lua.fzf_exec(
            cmd_string,
            vim.tbl_deep_extend("force", native_profile, {
              fzf_opts = { ["--delimiter"] = ":", ["--with-nth"] = 2 },
              actions = {
                ["default"] = function(selection, opts)
                  local input = selection[1]
                  local split_point = string.find(input, ":", 0, true) or 0
                  local file_path = string.sub(input, 0, split_point - 1)
                  require("fzf-lua.actions").file_switch_or_edit({ file_path }, opts)
                end,
              },
            })
          )
        end,
        desc = "Find packages",
      },
    },
    opts = {
      winopts = {
        height = 0.99,
        width = 0.99,
        preview = {
          horizontal = "right:60%",
        },
      },
      files = {
        previewer = "bat",
        git_icons = false,
        actions = {
          ["ctrl-h"] = actions.toggle_hidden,
          ["ctrl-i"] = actions.toggle_ignore,
        },
      },
      grep = {
        git_icons = false,
        rg_opts = [[ --glob '!.git' --glob '!*.lock' --glob '!licenses.json' --hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e ]],
      },
      previewers = {
        bat = {
          args = "--color=always --style=numbers,changes,header-filemodified,header-filename,grid",
        },
      },
    },
  },
}
