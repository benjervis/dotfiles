vim.filetype.add({
  pattern = {
    [".*%..+rc$"] = "json5",
    [".*"] = function(path)
      vim.print("Path:", path)
      if path:find("parcelrc", 1, true) ~= nil then
        return "json5"
      end
    end,
  },
})
