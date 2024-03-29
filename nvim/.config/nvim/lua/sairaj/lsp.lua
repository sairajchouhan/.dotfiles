local windows = require('lspconfig.ui.windows')
windows.default_options.border = "rounded"

vim.diagnostic.config({
  severity_sort = true,
  float = {
    border = "rounded"
  }
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded",
    title = "Hover"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    -- Use a sharp border with `FloatBorder` highlights
    border = "rounded",
    title = "Signature"
  }
)


-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end


  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', function()
    vim.lsp.buf.definition();
    vim.cmd("normal! zz")
  end, '[G]oto [D]efinition')

  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-S-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap("[d", function()
    vim.diagnostic.goto_prev();
    vim.cmd("normal! zz")
  end, "Go to next diagnostic")

  nmap("]d", function()
    vim.diagnostic.goto_next();
    vim.cmd("normal! zz")
  end, "Go to previous diagnostic")

  nmap("[e", function()
    vim.diagnostic.goto_prev({
      severity = vim.diagnostic.severity.ERROR
    })
    vim.cmd("normal! zz")
  end, "Go to next error diagnostic")

  nmap("]e", function()
    vim.diagnostic.goto_next({
      severity = vim.diagnostic.severity.ERROR
    })
    vim.cmd("normal! zz")
  end, "Go to previous error diagnostic")

  nmap(";d", function()
    vim.diagnostic.open_float({
      scope = "line",
    })
  end, "Show line diagnostics")


  nmap("F", function()
    vim.lsp.buf.format()
    vim.cmd("w");
  end)

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- gopls = {},
  -- pyright = {},
  rust_analyzer = {},
  tsserver = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        globals = { "P" },
      },
    },
  },
  clangd = {},
  bashls = {},
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    if server_name == "rust_analyzer" then
      local rt = require("rust-tools")

      rt.setup({
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = servers[server_name],
        },
      })

      return
    end

    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}
