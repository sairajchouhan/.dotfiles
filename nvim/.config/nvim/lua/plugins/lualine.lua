return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    -- set an empty statusline till lualine loads
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local opts = {
      options = {
        theme = "tokyonight",
        icons_enabled = false,
      },
      -- remove disagnostics symbols
      sections = {
        lualine_c = {
          {
            "diagnostics",
            symbols = {},
          },
        },
      },
      extensions = { "neo-tree", "lazy", "fzf", "mason", "trouble" },
    }
    return opts
  end,
}
