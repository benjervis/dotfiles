local wk = require("which-key")

return {
  "AndrewRadev/sideways.vim",
  keys = function()
    wk.add({ "<leader>S", group = "Sideways" })

    return {
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
    }
  end,
}
