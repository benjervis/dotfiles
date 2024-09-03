local root_selectors = require("config.root_selectors")
local cmd = require("utils.cmd")

M = {}

-- Copy the current file path relative to git root
-- Copy absolute path
-- Copy current path as CI link
-- Copy current range as CI link

---@enum (key) repo_types
local remote_prefixes = {
  github = {
    url_template = "https://github.com/$ORG/$REPO/blob/$BRANCH/$FILE_PATH",
    pattern = "git@github%.com:(.*)/(.*)%.?g?i?t?",
    line_prefix = "L",
  },
  stash = {
    url_template = "https://stash.atlassian.com/projects/$ORG/repos/$REPO/browse/$FILE_PATH?at=$BRANCH",
    pattern = "git@bitbucket.-/(.-)/(.-)%.git",
    line_prefix = "",
  },
}

---@param opts? {type: '"relative"' | '"absolute"'}
local get_buf_path = function(opts)
  opts = opts or { type = "relative" }

  local path = vim.fn.expand("%:p")

  if opts.type == "relative" then
    path = string.gsub(path, root_selectors.git() .. "/?", "", 1)
  end

  return path
end

---@param content string
---@param substitutions table<string, string> A table of keys to be replaced with the corresponding values
local template = function(content, substitutions)
  local result = content

  for k, v in pairs(substitutions) do
    result = result:gsub(k, v)
  end

  return result
end

---@param content string
local copy_to_clipboard = function(content)
  vim.fn.setreg("+", content)
end

M.copy_local_path = function()
  local file_path = get_buf_path()
  copy_to_clipboard(file_path)
end

M.copy_absolute_local_path = function()
  local absolute_path = get_buf_path({ type = "absolute" })
  copy_to_clipboard(absolute_path)
end

M.copy_remote_path = function()
  local file_path = get_buf_path()
  local mode = vim.fn.mode()

  local remote_url = cmd.run_shell_cmd({ "git", "remote", "get-url", "origin" })
  local current_branch = cmd.run_shell_cmd({ "git", "symbolic-ref", "--short", "HEAD" })

  ---@type repo_types
  local repo_type

  if remote_url:find("git@bitbucket", 1, true) ~= nil then
    repo_type = "stash"
  elseif remote_url:find("git@github", 1, true) then
    repo_type = "github"
  end

  if repo_type == nil then
    error("Unable to determine repo type of " .. remote_url)
  end

  local remote = remote_prefixes[repo_type]

  local _, _, org, repo = remote_url:find(remote.pattern)
  local url = template(remote.url_template, {
    ["$ORG"] = org,
    ["$REPO"] = repo,
    ["$BRANCH"] = current_branch,
    ["$FILE_PATH"] = file_path,
  })

  if mode == "v" or mode == "V" then
    local start_line, end_line = vim.fn.getpos("v")[2], vim.fn.getpos(".")[2]
    url = url .. "#" .. remote.line_prefix .. start_line
    if start_line ~= end_line then
      url = url .. "-" .. remote.line_prefix .. end_line
    end
  end

  copy_to_clipboard(url)
  vim.api.nvim_input("<Esc>")
end

return M
