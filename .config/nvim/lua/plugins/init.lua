return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "python-lsp-server",
                "black",
                "stylua",
                -- "pyright" -- cannot install due to ICU 75 (requires old version 73)
            }
        }
    },
    {
    "hrsh7th/nvim-cmp",
    opts = require "configs.cmp"
    },
    {
        "Vigemus/iron.nvim",
        -- main = "iron.core",
        -- opts = require "configs.iron",
        config = function()
            local iron = require("iron.core")
            iron.setup(require("configs.iron"))
            -- require "configs.iron"
        end,
        ft = {"python", "lua", "javascript"}
        -- main = "iron.core",
        -- opts = require "configs.iron",
    },
-- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
