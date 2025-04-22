local cmp = require("cmp")
local chad_cmp = require("nvchad.configs.cmp")
local M = chad_cmp


-- Resets Enter (Return) and S-Tab key
M.mapping["<CR>"] = cmp.config.disable
M.mapping["<S-Tab>"] = cmp.config.disable

-- Sets Tab as confirmation
M.mapping["<Tab>"] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Insert,
    select = true,
}

M.mapping["<Down>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }
)

M.mapping["<Up>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }
)
return M
