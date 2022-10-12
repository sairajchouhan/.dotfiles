local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
local icons = require "sairaj.icons"

telescope.setup {
  defaults = {
    prompt_prefix = icons.ui.Telescope .. " ",
    path_display = { "smart" },
    mappings = {
      n = {
        ["q"] = actions.close,
        ["esc"] = actions.close,
      },
    }
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        prompt_position = "top",
      },
    },
    diagnostics = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        prompt_position = "top",
        width = 0.75,
        height = 0.75,
      },
    },

   -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {

    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
}
