return {
  "saghen/blink.cmp",
  opts = {
    keymap = { preset = "enter" },
    completion = {
      menu = {
        border = "rounded",
      },
      ghost_text = {
        enabled = false,
      },
      documentation = {
        window = { border = "rounded" },
        auto_show = true,
        -- auto_show_delay_ms = 200,
      },
      list = {
        selection = {
          auto_insert = false,
        },
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
    },
    signature = { enabled = true, window = { border = "rounded" } },
  },
}
