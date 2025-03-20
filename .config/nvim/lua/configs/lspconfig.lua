-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                black = {
                    enabled = true,  -- Enable Black formatter
                    --line_length = 88 --
                },
            },
        },
    },
})
-- lspconfig.pyright.setup({
    -- on_attach = nvlsp.on_attach,
    -- capabilities = nvlsp.capabilities,
    -- filetypes = {"python"},
-- })


-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
