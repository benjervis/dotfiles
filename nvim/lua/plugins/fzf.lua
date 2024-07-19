local fzf_lua = require("fzf-lua")
local actions = require("fzf-lua.actions")
local native_profile = require("fzf-lua.profiles.fzf-native")
local root_selectors = require("config.root_selectors")
local pickers = require("config.pickers")

return {
  { "junegunn/fzf", build = "./install --all --xdg --no-bash --no-zsh" },
  { "junegunn/fzf.vim" },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><space>", pickers.pick_files("workspace"), desc = "Find files - Workspace" },
      { "<leader>ff", pickers.pick_files("lsp"), desc = "Find files - LSP" },
      { "<leader>fF", pickers.pick_files("git"), desc = "Find files - Repo" },
      { "<leader>fr", pickers.pick_old_files("git"), desc = "Recent files" },
      { "<leader>fn", pickers.pick_node_modules("workspace"), desc = "Find node_modules" },
      { "<leader>sg", LazyVim.pick("live_grep", { cwd = LazyVim.root.git() }), desc = "Grep - Repo" },
      {
        "<leader>fp",
        function()
          local cmd_string = string.format(
            'rg \z
            \'"name": "(.+)"\' \z
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
      files = {
        actions = {
          ["ctrl-h"] = actions.toggle_hidden,
          ["ctrl-i"] = actions.toggle_ignore,
        },
      },
      grep = {
        cmd = "rg",
      },
    },
  },
}
