local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        sorting_strategy = 'ascending',
        layout_config = {
          prompt_position = 'top',
        },
        -- always ignore .git folders
        file_ignore_patterns = { '%.git/' },
        mappings = {
          n = {
            ['<C-w>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          i = {
            ['<C-w>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        live_grep = {
          layout_config = {
            preview_width = 0.5,
          },
        },
        find_files = {
          hidden = true,
          theme = 'ivy',
        },
        lsp_references = {
          show_line = false,
          layout_config = {
            preview_width = 0.6,
          },
        },
        oldfiles = {
          only_cwd = true,
        },
      },
      extensions = {},
    }

    pcall(require('telescope').load_extension, 'fzf')

    local telescope_themes = require 'telescope.themes'
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Search by grep' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Search help' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Search current word' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Search keymaps' })
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Search old files' })

    vim.keymap.set('n', '<leader>fc', function()
      require('telescope.builtin').command_history(telescope_themes.get_dropdown {
        previewer = false,
      })
    end, { desc = 'Search command history' })
    vim.keymap.set('n', '<leader>fs', function()
      require('telescope.builtin').spell_suggest(telescope_themes.get_dropdown {
        previewer = false,
      })
    end, { desc = 'Search spelling suggestions' })
  end,
}
