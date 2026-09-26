return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "ts_ls", "clangd", "lua_ls", "jdtls", "bashls" },
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
        capabilities = capabilities,
			})

			-- Keymaps remain the same
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

			vim.keymap.set("n", "B", function()
				vim.diagnostic.open_float(nil, {
					border = "rounded",
					source = "always",
					focusable = true, -- allow you to click / scroll it
					scope = "line", -- show only diagnostics for the current line
				})
			end, { desc = "Show diagnostic message under cursor" })
		end,
	},
}

--[[
  Hiding nvim-lspconfig deprecation warning for now.
  The warning says:
    "require('lspconfig') framework is deprecated, use vim.lsp.config"
  This does not break functionality, and until v3.0.0 release,
  using require('lspconfig') is safe.
--]]
