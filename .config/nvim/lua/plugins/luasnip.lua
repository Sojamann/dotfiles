return {
  'L3MON4D3/LuaSnip',
  tag = "v2.*",
  dependencies = {
    'saadparwaiz1/cmp_luasnip',

    -- Adds a number of user-friendly snippets
    {
      'rafamadriz/friendly-snippets',
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end
    }
  },
  config = function()
    local ls = require("luasnip")
    local types = require("luasnip.util.types")

    --
    -- Config
    --
    -- see: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#config-options
    ls.setup({
      keep_roots = true,
      link_roots = true,
      link_children = true,
      enable_autosnippets = true, -- TODO: might not be used
      -- used for dynamic snippets
      update_events = { "TextChanged", "TextChangedI" },
      -- for the highlighting
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "←", "Error" } }
          }
        }
      }
    })

    --
    -- Keymaps
    --

    -- CTRL-k : expand snippet or go to next field
    vim.keymap.set({ "i", "s" }, "<c-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true, desc = "Expand snippet or jump to next field" })

    -- CTRL-j : jump backwards a field in the snippet
    vim.keymap.set({ "i", "s" }, "<c-j>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true, desc = "Jump back one field in the snippet" })

    -- CTRL-l : cycle through expanable snippets
    vim.keymap.set({ "i", "s" }, "<c-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true, desc = "Jump back one field in the snippet" })

    --
    -- Snippets
    --
    ls.add_snippets("lua", {
      ls.parser.parse_snippet("expand", "local $1 = function($2)\n  $0\nend")
    }) -- most basic example snippet
  end
}
