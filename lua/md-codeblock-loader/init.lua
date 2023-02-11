local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

local read_file = function(filename, _start, _end)
  -- return lines from _start to _end
  local result = {}
  local f = io.open(filename, "r")
  if f == nil then
    return result
  end

  local current = 0
  for line in f:lines() do
    current = current + 1
    if _end ~= 0 then
      if current >= _start and current <= _end then
        table.insert(result, line)
      end
      if current > _end then
        break
      end
    else
      if current >= _start then
        table.insert(result, line)
      end
    end
  end
  f:close()
  return result
end

local _find_code_block = function(search_range)
  -- find code_fence_content node
  -- Cursor must be on ``` delimiter
  search_range = search_range or 10
  local code_fence_content_type = "code_fence_content"
  local fenced_code_block_delimiter_type = "fenced_code_block_delimiter"

  local current_node = ts_utils.get_node_at_cursor()

  if current_node:type() ~= fenced_code_block_delimiter_type then
    print("Cursor must be on ``` delimiter")
    return nil
  end

  local next_node = current_node
  for _ = 0, search_range do

    if next_node == nil then
      break
    end

    if next_node:type() == code_fence_content_type then
      return next_node
    end

    local parent_node = next_node:parent()
    for _ = 0, search_range do
      if parent_node == nil then
        break
      end
      if parent_node:type() == code_fence_content_type then
        return parent_node
      end
      parent_node = parent_node:parent()
    end

    next_node = next_node:next_named_sibling()
  end

  print("not found")

end

M.load = function(filename, _start, _end)
  -- load file contents and write into code block
  _start = _start or 1
  _end = _end or 0

  local code_block_node = _find_code_block()
  if code_block_node == nil then
    return
  end

  local lines = read_file(filename, _start, _end)
  local start = code_block_node:start()
  local end_ = code_block_node:end_()

  vim.api.nvim_buf_set_lines(0, start, end_, false, lines)
end

return M
