local status_ok, null_ls = pcall(require, "null-ls")

if not status_ok then
  return
end


null_ls.setup({
  sources = {
    --[[ null_ls.builtins.diagnostics.eslint, ]]
    null_ls.builtins.formatting.prettier
  },
})

-- deamon version for eslint and prettier
--[[ sources = { ]]
--[[     null_ls.builtins.diagnostics.eslint_d, ]]
--[[     null_ls.builtins.formatting.prettierd ]]
--[[ }, ]]

