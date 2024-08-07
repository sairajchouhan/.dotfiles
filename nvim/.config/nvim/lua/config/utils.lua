-- Debug function that logs to a file
local function log_to_file(message)
  local log_file = vim.fn.stdpath 'data' .. '/mine.log'
  local file = io.open(log_file, 'a')
  if file then
    file:write(os.date '%Y-%m-%d %H:%M:%S' .. ' ' .. vim.inspect(message) .. '\n')
    file:close()
  end
end

P = function(v, should_log_to_file)
  print(vim.inspect(v))
  if should_log_to_file then
    log_to_file(v)
  end
  return v
end
