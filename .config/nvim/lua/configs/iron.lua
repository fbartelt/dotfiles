local iron = require("iron.core")
local view = require("iron.view")
local common = require("iron.fts.common")

-- local my_python_env = "/home/fbartelt/Documents/UFMG/Programacao Linear/TP/cplex-env/bin"
local my_python_env = "/home/fbartelt/Documents/Projetos/robotics-experiments/vfobstacle/manimenv/bin"
return {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = {"zsh"}
      },
      python = {
        command = { "ipython", "--no-autoindent" },
        -- command = { my_python_env .. "/ipython" , "--no-autoindent" },
        format = function(lines, extras)
            local result = require("iron.fts.common").bracketed_paste_python(lines, extras)
            -- Remove comments
            local uncomment = vim.tbl_filter(function(line) return not string.match(line, "^%s*#") end, result)
            return uncomment
        end,
        -- format = common.bracketed_paste_python,
        block_dividers = { "# %%", "#%%" },
        -- venv_python = {
        --                 command = "cplex-env/bin/python"
        --             }
      }
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
    repl_open_cmd = view.split.vertical("50%"), 

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
    toggle_repl = "<leader>ii",-- toggles the repl open and closed.
    -- If repl_open_command is a table as above, then the following keymaps are
    -- available
    -- toggle_repl_with_cmd_1 = "<leader>rv",
    -- toggle_repl_with_cmd_2 = "<leader>rh",
    restart_repl = "<leader>ir",-- calls `IronRestart` to restart the repl
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
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- -- iron also has a list of commands, see :h iron-commands for all available commands
-- vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>')
-- vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>')
