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
        "clangd",
        -- "pyright" -- cannot install due to ICU 75 (requires old version 73)
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = require "configs.cmp",
  },
  {
    "Vigemus/iron.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    -- main = "iron.core",
    -- opts = require "configs.iron",
    config = function()
      local iron = require "iron.core"
      iron.setup(require "configs.iron")
      -- require "configs.iron"
    end,
    ft = { "python", "lua", "javascript" },
    -- main = "iron.core",
    -- opts = require "configs.iron",
  },
  -- Github Copilot
  {
    "github/copilot.vim",
    lazy = false,
    config = require "configs.copilot",
  },
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      require "configs.vimtex"
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- lazy = false,
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    ft = { "markdown" },
    opts = {
        enabled = true,
        render_modes = { 'n', 'c', 't' },
        -- file_types = { "markdown", "vimwiki" },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "python",
        "c",
        "cpp",
        "cmake",
        -- "latex",
        "bash",
        "liquid",
        "html",
        "css",
        "scss",
        "markdown",
        "matlab",
        "markdown_inline",
        "yuck",
      },
    },
  },
  -- {
  --     "goerz/jupytext.nvim",
  --     version = '0.2.0',
  --     opts = {},
  -- },
  -- opts = {
  --     format = "py:percent"
  -- }
  -- config = function ()
  --             -- require("jupytext").setup(require("configs.jupytext"))
  --         -- end
  --         -- opts = require "configs.jupytext"  -- see Options
  --     },
}
