if vim.g.vscode then
  require 'config.opts'
  return
end

require("config.globals")
require("config.opts")
require("config.autocmd")
require("config.keymaps")
require("config.lazy")
