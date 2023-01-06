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
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top"
    },
    mappings = {
      n = {
        ["q"] = actions.close,
      },
    }
  }
}
