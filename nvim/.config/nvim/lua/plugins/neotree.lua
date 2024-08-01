return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set("n", "<leader>e", function()
      vim.cmd("Neotree toggle")
    end)

    require("neo-tree").setup({
      close_if_last_window = true,
      use_libuv_file_watcher = true,
      popup_border_style = "rounded",
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = {
            ".DS_Store",
            ".git"
          },
        },
        follow_current_file = {
          enabled = true
        }
      }
    })
  end
}
