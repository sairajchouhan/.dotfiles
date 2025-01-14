return {
  'romgrk/barbar.nvim',
  enabled = true,
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  config = function()
    local barbar = require 'barbar'

    barbar.setup {
      sidebar_filetypes = {
        ['neo-tree'] = { event = 'BufWipeout' },
      },
      icons = {
        pinned = { button = '', filename = true },
        filetype = { enabled = false },
      },
    }

    local highlight_groups = {
      'BufferCurrent',
      -- 'BufferCurrentIndex',
      -- 'BufferCurrentMod',
      'BufferCurrentSign',
      -- 'BufferCurrentTarget',
      -- 'BufferVisible',
      -- 'BufferVisibleIndex',
      -- 'BufferVisibleMod',
      -- 'BufferVisibleSign',
      -- 'BufferVisibleTarget',
      'BufferInactive',
      -- 'BufferInactiveMod',
      'BufferInactiveSign',
      -- 'BufferInactiveTarget',
      -- 'BufferTabpages',
      'BufferTabpageFill',
    }

    for _, group in ipairs(highlight_groups) do
      local current_hl = vim.api.nvim_get_hl(0, { name = group })
      local new_hl = { bg = '#000000' }

      -- Preserve foreground color if it exists
      if current_hl.fg then
        new_hl.fg = string.format('#%06x', current_hl.fg)
      end

      -- Preserve other attributes
      for attr, value in pairs(current_hl) do
        if attr ~= 'fg' and attr ~= 'bg' then
          new_hl[attr] = value
        end
      end

      vim.api.nvim_set_hl(0, group, new_hl)
    end

    -- Set the BufferOffset to black (this is for the area next to the tabs)
    vim.api.nvim_set_hl(0, 'BufferOffset', { bg = '#000000' })
  end,
  version = '^1.9.0',
}
