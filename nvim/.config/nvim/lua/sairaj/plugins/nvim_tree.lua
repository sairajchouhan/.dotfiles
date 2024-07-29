return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    local tree = require('nvim-tree.api').tree
    local view = require 'nvim-tree.view'
    local api = require 'nvim-tree.api'
    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd

    vim.api.nvim_create_autocmd('VimEnter', {
      desc = 'open nvim tree on vim enter',
      group = vim.api.nvim_create_augroup('nvim-tree-open', { clear = true }),
      callback = function()
        tree.open()
      end,
    })

    -- Make :bd and :q behave as usual when tree is visible
    vim.api.nvim_create_autocmd({ 'BufEnter', 'QuitPre' }, {
      nested = false,
      callback = function(e)
        -- Nothing to do if tree is not opened
        if not tree.is_visible() then
          return
        end

        -- How many focusable windows do we have? (excluding e.g. incline status window)
        local winCount = 0
        for _, winId in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_config(winId).focusable then
            winCount = winCount + 1
          end
        end

        -- We want to quit and only one window besides tree is left
        if e.event == 'QuitPre' and winCount == 2 then
          vim.api.nvim_cmd({ cmd = 'qall' }, {})
        end

        -- :bd was probably issued an only tree window is left
        -- Behave as if tree was closed (see `:h :bd`)
        if e.event == 'BufEnter' and winCount == 1 then
          -- Required to avoid "Vim:E444: Cannot close last window"
          vim.defer_fn(function()
            -- close nvim-tree: will go to the last buffer used before closing
            tree.toggle { find_file = true, focus = true }
            -- re-open nivm-tree
            tree.toggle { find_file = true, focus = false }
          end, 10)
        end
      end,
    })

    augroup('save_nvim_tree_width', { clear = true })
    autocmd('WinResized', {
      group = 'save_nvim_tree_width',
      pattern = '*',
      callback = function()
        local filetree_winnr = view.get_winnr()
        if filetree_winnr ~= nil and vim.tbl_contains(vim.v.event['windows'], filetree_winnr) then
          vim.t['filetree_width'] = vim.api.nvim_win_get_width(filetree_winnr)
        end
      end,
    })

    -- restore window size when openning nvim-tree
    api.events.subscribe(api.events.Event.TreeOpen, function()
      if vim.t['filetree_width'] ~= nil then
        view.resize(vim.t['filetree_width'])
      end
    end)

    vim.keymap.set('n', '<leader>e', function()
      if tree.is_visible() then
        vim.cmd 'NvimTreeClose'
        return
      end

      api.tree.find_file { open = true, focus = true }
    end)

    return {
      git = {
        ignore = false,
      },
      update_focused_file = {
        enable = true,
      },
      view = {
        float = {
          enable = false,
        },
        adaptive_size = false,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          git_placement = 'signcolumn',
          glyphs = {
            git = {
              unstaged = 'M',
              renamed = 'R',
              untracked = '?',
              deleted = 'D',
              ignored = '◌',
              unmerged = '',
              staged = 'S',
            },
          },
        },
      },
      actions = {
        open_file = {
          resize_window = false,
        },
      },
    }
  end,
}
