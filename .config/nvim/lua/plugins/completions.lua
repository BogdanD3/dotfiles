return {
  
{
  "github/copilot.vim",
  config = function()
    _G.copilot_enabled = true

    function _G.toggle_copilot()
      if _G.copilot_enabled then
        vim.cmd("Copilot disable")
        print(" Copilot: OFF")
      else
        vim.cmd("Copilot enable")
        print(" Copilot: ON")
      end
      _G.copilot_enabled = not _G.copilot_enabled
    end

    -- Add a simple normal-mode keymap
    vim.keymap.set(
      "n",
      "<leader>tc",
      toggle_copilot,
      { noremap = true, silent = true, desc = "Toggle Copilot" }
    )
  end,
},

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      _G.snippets_enabled = true

      -- Load VSCode-style snippets
      require("luasnip.loaders.from_vscode").lazy_load()

        -- Custom C starter snippet
        require("luasnip").add_snippets("c", {
          require("luasnip").snippet("main", {
            require("luasnip").text_node({
              "#include <stdio.h>",
              "#include <stdlib.h>",
              "",
              "int main() {",
              "    // Your code here",
              "    return 0;",
              "}"
            }),
          }),
        })

      -- Optional: snippet history & auto jump
      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          -- Tab navigation for completion/snippets
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        -- **sources**: LSP + snippets + buffer
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            option = {},
            entry_filter = function(entry)
              return _G.snippets_enabled
            end,
          },
          {
            name = "luasnip",
            option = {},
            entry_filter = function(entry)
              return _G.snippets_enabled
            end,
          },
        }, {
          {
            name = "buffer",

            option = {},
            entry_filter = function(entry)
              return _G.snippets_enabled
            end,
          },
        }),

        -- **trigger completion automatically as you type** like the video
        completion = {
          autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
        },
      })

      vim.api.nvim_set_keymap(
        "n",
        "<leader>ts",
        "<cmd>lua _G.snippets_enabled = not _G.snippets_enabled; require('cmp').close(); print('Snippets: ' .. (_G.snippets_enabled and 'ON' or 'OFF'))<CR>",
        { noremap = true, silent = true }
      )
    end,
  },
}
