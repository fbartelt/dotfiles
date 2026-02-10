-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "pylsp", "clangd" } -- add more servers here
local nvlsp = require "nvchad.configs.lspconfig"

-- base config shared by all servers
local base = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- servers with default config
for _, server in ipairs(servers) do
  vim.lsp.config(server, base)
  vim.lsp.enable(server)
end

-- pylsp with extra settings
vim.lsp.config("pylsp", vim.tbl_deep_extend("force", base, {
  settings = {
    pylsp = {
      plugins = {
        black = {
          enabled = true, -- Enable Black formatter
        },
        pycodestyle = {
            maxLineLength = 88, -- Set max line length for pycodestyle
        }
      },
    },
  },
}))
vim.lsp.enable("pylsp")

-- clangd with override
vim.lsp.config("clangd", vim.tbl_deep_extend("force", base, {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    nvlsp.on_attach(client, bufnr)
  end,
}))
vim.lsp.enable("clangd")
-- lsps with default config
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = nvlsp.on_attach,
--     on_init = nvlsp.on_init,
--     capabilities = nvlsp.capabilities,
--   }
-- end
--
-- lspconfig.pylsp.setup({
--     settings = {
--         pylsp = {
--             plugins = {
--                 black = {
--                     enabled = true,  -- Enable Black formatter
--                     --line_length = 88 --
--                 },
--             },
--         },
--     },
-- })
--
-- lspconfig.clangd.setup {
--     on_attach = function(client, bufnr)
--         client.server_capabilities.signatureHelpProvider = false
--         nvlsp.on_attach(client, bufnr)
--     end,
--     capabilities = nvlsp.capabilities,
-- }
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
