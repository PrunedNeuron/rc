-- ============================================================================
-- Colorscheme Persistence and Management Utilities
-- ============================================================================
-- Complexity: O(1) file I/O operations
-- Cache location: ~/.cache/nvim/colorscheme.txt

local M = {}

local cache_file = vim.fn.stdpath("cache") .. "/colorscheme.txt"

--- Save colorscheme to persistent cache
--- @return boolean success
function M.save()
  local scheme = vim.g.colors_name
  if not scheme then
    return false
  end

  local file = io.open(cache_file, "w")
  if not file then
    vim.notify("Failed to save colorscheme", vim.log.levels.ERROR)
    return false
  end

  file:write(scheme)
  file:close()
  return true
end

--- Load colorscheme from cache
--- @return string|nil scheme name
function M.load()
  local file = io.open(cache_file, "r")
  if not file then
    return nil
  end

  local scheme = file:read("*all")
  file:close()
  return scheme and vim.trim(scheme) or nil
end

--- Set colorscheme with error handling and persistence
--- @param name string colorscheme name
--- @return boolean success
function M.set(name)
  local ok = pcall(vim.cmd.colorscheme, name)
  if ok then
    M.save()
    vim.notify("Colorscheme: " .. name, vim.log.levels.INFO)
    return true
  else
    vim.notify("Failed to load colorscheme: " .. name, vim.log.levels.ERROR)
    return false
  end
end

--- Cycle to next/previous colorscheme
--- @param direction number 1 for next, -1 for previous
function M.cycle(direction)
  local schemes = vim.fn.getcompletion("", "color")
  local current = vim.g.colors_name

  local idx = 1
  for i, scheme in ipairs(schemes) do
    if scheme == current then
      idx = i
      break
    end
  end

  idx = idx + direction
  if idx > #schemes then
    idx = 1
  elseif idx < 1 then
    idx = #schemes
  end

  M.set(schemes[idx])
end

return M
