if vim.g.vscode then
  require 'config.opts'
  require 'config.vscode'
  return
end

require 'config.utils'
require 'config.opts'
require 'config.global'
require 'config.keymaps'
require 'config.lazy'
