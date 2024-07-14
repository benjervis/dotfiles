return {
  { "junegunn/fzf", build = "./install --all --xdg --no-bash --no-zsh" },
  { "junegunn/fzf.vim" },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><space>", LazyVim.pick("files", { cwd = LazyVim.root.git() }), desc = "Find files - Git" },
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
      {
        "<leader>fp",
        function()
          local fzf_lua = require("fzf-lua")
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

          fzf_lua.fzf_exec(cmd_string, {
            -- fzf_opts = { ["--delimiter"] = ":", ["--with-nth"] = 2 },
            fn_transform = function(input)
              vim.print("Input:", input)
              local split_point = string.find(input, ":", 1, true) or 1
              vim.print("Split: ", split_point)
              -- local file_path = string.sub(input, 0, split_point - 1)
              -- local package_name = string.sub(input, split_point + 1, -2)

              -- return package_name
              return string.sub(input, split_point + 1, -2)
            end,

            actions = {
              ["default"] = function(selection, opts)
                local input = selection[1]
                vim.print("Selection: ", selection)
                vim.print("Input:", input)
                local split_point = string.find(input, ":", 0, true) or 0
                local file_path = string.sub(input, 0, split_point - 1)
                vim.print("File path:", file_path)
                require("fzf-lua.actions").file_switch_or_edit({ file_path }, opts)
              end,
            },
          })
        end,
        desc = "Productivity++",
      },
    },
    config = function()
      local actions = require("fzf-lua.actions")
      return {
        grep = {
          actions = {
            ["ctrl+r"] = actions.toggle_ignore,
            ["ctrl+h"] = actions.toggle_hidden,
          },
        },
        files = {
          actions = {
            ["ctrl+h"] = actions.toggle_hidden,
          },
        },
      }
    end,
  },
}
