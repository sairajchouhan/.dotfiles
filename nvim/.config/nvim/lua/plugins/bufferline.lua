-- TODO: show other buffers except current one in italics currently it's opposite
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>fp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
  },
  opts = {
    options = {
      always_show_bufferline = false,
      diagnostics_indicator = function()
        return ""
      end,
    },
  },
  config = function(_)
    local bufferline = require("bufferline")

    local opts = {
      options = {
        always_show_bufferline = false,
        diagnostics_indicator = function()
          return ""
        end,
        style_preset = { bufferline.style_preset.no_italic, bufferline.style_preset.minimal },
      },
    }

    bufferline.setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
