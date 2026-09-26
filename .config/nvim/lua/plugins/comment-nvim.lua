return {
  "numToStr/Comment.nvim",
  lazy = false,
  config = function()
    local comment = require("Comment")
    comment.setup()

    -- Normal mode toggle
    vim.keymap.set("n", "<leader>co", "<Plug>(comment_toggle_linewise)", {
      desc = "Toggle comment (linewise)",
    })

    -- Visual mode toggle
    vim.keymap.set("v", "<leader>co", "<Plug>(comment_toggle_linewise_visual)", {
      desc = "Toggle comment (linewise visual)",
    })
  end,
}
