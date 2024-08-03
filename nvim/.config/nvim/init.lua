if vim.g.vscode then
  require 'config.opts'
  return
end

require("config.utils")
require("config.opts")
require("config.autocmd")
require("config.keymaps")
require("config.lazy")
