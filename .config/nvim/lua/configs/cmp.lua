local cmp = require("cmp")
local chad_cmp = require("nvchad.configs.cmp")
local M = chad_cmp


-- Resets Enter (Return) key
M.mapping["<CR>"] = function(fallback)
    fallback()
end

-- Sets Ctrl+Enter as confirmation
M.mapping["<C-CR>"] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Insert,
    select = true,
}

return M
