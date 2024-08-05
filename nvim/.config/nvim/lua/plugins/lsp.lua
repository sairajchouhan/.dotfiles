return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		{ "j-hui/fidget.nvim", opts = {} },

		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
			title = "Hover",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
			title = "Signature",
		})

		vim.diagnostic.config({
			severity_sort = true,
			float = {
				border = "rounded",
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- TODO: wtf? does this C-t work have to test
				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map("gD", vim.lsp.buf.declaration, "Goto declaration")
				map("gI", require("telescope.builtin").lsp_implementations, "Goto implementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type definition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document symbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code action")

				map("[d", function()
					vim.diagnostic.goto_prev()
					vim.cmd("normal! zz")
				end, "Go to next diagnostic")

				map("]d", function()
					vim.diagnostic.goto_next()
					vim.cmd("normal! zz")
				end, "Go to previous diagnostic")

				map("[e", function()
					vim.diagnostic.goto_prev({
						severity = vim.diagnostic.severity.ERROR,
					})
					vim.cmd("normal! zz")
				end, "Go to next error diagnostic")

				map("]e", function()
					vim.diagnostic.goto_next({
						severity = vim.diagnostic.severity.ERROR,
					})
					vim.cmd("normal! zz")
				end, "Go to previous error diagnostic")

				map(";d", function()
					vim.diagnostic.open_float({
						scope = "line",
					})
				end, "Show line diagnostics")

				map("gd", function()
					require("telescope.builtin").lsp_definitions({})
					vim.cmd("normal! zz")
				end, "Goto definition")

				map("gr", function()
					require("telescope.builtin").lsp_references({})
				end, "Goto references")

				-- highlight references of the word under your cursor when your cursor rests there for a little while.
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "Toggle inlay hints")
				end
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			-- clangd = {},
			-- gopls = {},
			-- pyright = {},
			-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
			--
			-- TODO: have to check how useful this is https://github.com/pmizio/typescript-tools.nvim
			rust_analyzer = {},
			tsserver = {},
			lua_ls = {
				-- cmd = {...},
				-- filetypes = { ...},
				-- capabilities = {},
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},
		}

		require("mason").setup({
			ui = {
				border = "rounded",
			},
		})

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"prettierd",
			"eslint_d",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
