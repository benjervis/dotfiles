local pickers = require("config.pickers")

return {
  "nvimdev/dashboard-nvim",
  opts = function()
    local logo = [[
       ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
       ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
       ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
       ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
       ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
       ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
  ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
      -- stylua: ignore
          center = {
            { action = pickers.pick_files("git"),                                                                         desc = " Find File",       icon = " ", key = "f" },
            { action = "ene | startinsert",                                                                               desc = " New File",        icon = " ", key = "n" },
            { action = pickers.pick_old_files("git"),                                                                     desc = " Recent Files",    icon = " ", key = "r" },
            { action = LazyVim.pick("live_grep",    { cwd = LazyVim.root.git() }),                                        desc = " Find Text",       icon = " ", key = "g" },
            { action = 'lua require("persistence").load()',                                                               desc = " Restore Session", icon = " ", key = "s" },
            { action = function () LazyVim.lazygit( { cwd = LazyVim.root.git(), size = {width = 1, height=0.98} }) end,   desc = " Lazygit",         icon = " ", key = "G" },
            { action = "LazyExtras",                                                                                      desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                                                                                            desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                                                              desc = " Quit",            icon = " ", key = "q" },
          },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
