return {
  "nvimtools/none-ls.nvim",
  config = function()
    -- silence eslint_d warning before loading none-ls
    local notify = vim.notify
    vim.notify = function(msg, level, opts)
      if type(msg) == "string" and msg:match("failed to load builtin eslint_d") then
        return
      end
      notify(msg, level, opts)
    end

    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.shmt,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
