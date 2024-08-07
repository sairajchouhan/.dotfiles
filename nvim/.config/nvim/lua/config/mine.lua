vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank {
      timeout = 30,
    }
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Open help on right side split',
  group = vim.api.nvim_create_augroup('help_window_right', {}),
  pattern = { '*.txt' },
  callback = function()
    if vim.o.filetype == 'help' then
      vim.cmd.wincmd 'L'
    end
  end,
})

----------------------------------

local main_commands = { 'relative_line_numbers' }
local args = { [main_commands[1]] = { 'toggle', 'on', 'off' } }

vim.api.nvim_create_user_command('Customise', function(opts)
  local fargs = opts.fargs

  if fargs[1] == 'relative_line_numbers' then
    if fargs[2] == 'toggle' then
      if vim.wo.relativenumber then
        vim.cmd 'set norelativenumber'
      else
        vim.cmd 'set relativenumber'
      end
    end

    if fargs[2] == 'on' then
      vim.cmd 'set relativenumber'
    end

    if fargs[2] == 'off' then
      vim.cmd 'set norelativenumber'
    end
  end
end, {
  nargs = '+',
  complete = function(_, line)
    local words = vim.split(line, '%s+')
    local n = #words

    if n == 2 then
      return main_commands
    elseif n == 3 and args[words[2]] then
      return args[words[2]]
    end

    return {}
  end,
})
