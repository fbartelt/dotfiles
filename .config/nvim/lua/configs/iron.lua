local nvim = vim.api
local iron = require "iron.core"
local view = require "iron.view"
local common = require "iron.fts.common"
local telescope = require "telescope.builtin"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
-- local user_config = require "configs.iron"

local M = {}

local function set_python_repl()
  local command = {
    "fd",
    "-t",
    "x",
    "-t",
    "l",
    "^python[0-9.]*$", -- matches python, python3.10, etc.
    os.getenv "HOME",
    "/usr/bin",
    "--ignore-case",
    "--hidden",
    "--no-ignore",
    "--exclude",
    ".cache",
  }

  pickers
    .new({}, {
      prompt_title = "Select Python Environment",
      finder = finders.new_oneshot_job(command, {
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry,
            ordinal = entry,
            path = entry,
          }
        end,
      }),
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if not selection then
            return
          end

          local path = vim.fn.fnamemodify(selection.value, ":p:h") -- get dirname
          local ipython_path = path .. "/ipython"
          local ft = nvim.nvim_get_option_value("filetype", { buf = 0 })

          M.config.repl_definition.python.command = { ipython_path, "--no-autoindent" }
          iron.setup(M)
          -- Restart the REPL with the new command iron.core.repl_restart
          iron.repl_restart()

          print("Selected REPL for '" .. ft .. "': " .. ipython_path)
        end)
        return true
      end,
    })
    :find()
end

vim.api.nvim_create_user_command("PickPythonEnv", set_python_repl, {})
vim.keymap.set("n", "<leader>i]", ":PickPythonEnv<CR>", { desc = "Pick Python Interpreter" })

M = {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = { "zsh" },
      },
      python = {
        command = { "ipython", "--no-autoindent" },
        -- command = { my_python_env .. "/ipython" , "--no-autoindent" },
        format = function(lines, extras)
          local result = require("iron.fts.common").bracketed_paste_python(lines, extras)
          -- Remove comments
          local uncomment = vim.tbl_filter(function(line)
            return not string.match(line, "^%s*#")
          end, result)
          return uncomment
        end,
        -- format = common.bracketed_paste_python,
        block_dividers = { "# %%", "#%%" },
        -- venv_python = {
        --                 command = "cplex-env/bin/python"
        --             }
      },
    },
    -- set the file type of the newly created repl to ft
    -- bufnr is the buffer id of the REPL and ft is the filetype of the
    -- language being used for the REPL.
    repl_filetype = function(bufnr, ft)
      return ft
      -- or return a string name such as the following
      -- return "iron"
    end,
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = view.split.vertical "50%",

    -- repl_open_cmd can also be an array-style table so that multiple
    -- repl_open_commands can be given.
    -- When repl_open_cmd is given as a table, the first command given will
    -- be the command that `IronRepl` initially toggles.
    -- Moreover, when repl_open_cmd is a table, each key will automatically
    -- be available as a keymap (see `keymaps` below) with the names
    -- toggle_repl_with_cmd_1, ..., toggle_repl_with_cmd_k
    -- For example,
    --
    -- repl_open_cmd = {
    --   view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
    --   view.split.rightbelow("%25")  -- cmd_2: open a repl below
    -- }
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    toggle_repl = "<leader>ii", -- toggles the repl open and closed.
    -- If repl_open_command is a table as above, then the following keymaps are
    -- available
    -- toggle_repl_with_cmd_1 = "<leader>rv",
    -- toggle_repl_with_cmd_2 = "<leader>rh",
    restart_repl = "<leader>ir", -- calls `IronRestart` to restart the repl
    send_motion = "leader>i<CR>",
    visual_send = "<leader>i<CR>",
    send_file = "<leader>if",
    send_line = "<leader>il",
    send_paragraph = "<leader>ip",
    send_until_cursor = "<leader>iu",
    send_mark = "<leader>im",
    send_code_block = "<leader>ib",
    send_code_block_and_move = "<leader>in",
    mark_motion = "<leader>im",
    mark_visual = "<leader>im",
    remove_mark = "<leader>imd",
    cr = "<leader>i<Tab>",
    interrupt = "<leader>iq",
    exit = "<leader>ix",
    clear = "<leader>ic",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true,
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

return M
-- -- iron also has a list of commands, see :h iron-commands for all available commands
-- vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>')
-- vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>')
