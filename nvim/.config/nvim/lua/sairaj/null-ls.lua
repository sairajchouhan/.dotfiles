require("mason").setup()

local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        local arr = { ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs" }
        for _, file in ipairs(arr) do
          if utils.root_has_file(file) then
            return true
          end
        end
      end,
    })
  },
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      -- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   group = augroup,
      --   buffer = bufnr,
      --   callback = function()
      --     vim.lsp.buf.format({
      --       filter = function(client)
      --         --  only use null-ls for formatting instead of lsp server
      --         return client.name == "null-ls"
      --       end,
      --       bufnr = bufnr,
      --     })
      --   end,
      -- })
    end
  end,
})



require("mason-null-ls").setup({
  ensure_installed = {
    "prettier",
    "eslint_d",
  },
  automatic_installation = true,
  automatic_setup = false,
})
