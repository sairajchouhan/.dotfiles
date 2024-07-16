M = {}

local num = 0

vim.api.nvim_set_keymap('n', '<leader>cl', ':Cbugger<CR>', { noremap = true, silent = true })

vim.api.nvim_create_user_command('Cbugger', function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local final_str = 'console.log(`' .. num .. ': '

  local cursor_node = vim.treesitter.get_node()

  if cursor_node and cursor_node:child_count() == 0 then
    local cursor_node_text = vim.treesitter.get_node_text(cursor_node, 0)
    if cursor_node_text then
      final_str = final_str .. '${' .. cursor_node_text .. '}'
    end
  end

  final_str = final_str .. '`);'

  -- remove all new lines
  final_str = string.gsub(final_str, '\n', '')

  local indent_level = vim.fn.indent(vim.fn.line '.')

  if indent_level > 0 then
    final_str = string.rep(' ', indent_level) .. final_str
  end

  vim.api.nvim_buf_set_lines(0, cursor[1], cursor[1], false, { final_str })

  num = num + 1
end, {})

vim.api.nvim_create_user_command('CbuggerClear', function()
  num = 0
end, {})

return M
