return function()
    vim.g.copilot_no_tab_map = true -- disable default <Tab>

    -- Custom keymaps for Copilot
    vim.keymap.set("i", "<M-y>", 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false,
    silent = true,
    })

    vim.keymap.set("i", "<M-w>", "<Plug>(copilot-accept-word)", { silent = true })
    vim.keymap.set("i", "<M-l>", "<Plug>(copilot-accept-line)", { silent = true })
    vim.keymap.set("i", "<M-s>", "<Plug>(copilot-suggest)", { silent = true }) -- example using Alt+s
    vim.keymap.del("i", "<M-Bslash>") -- remove original Alt+Backslash
    -- Optional: Remove default mappings if desired
    vim.keymap.del("i", "<M-Right>")
    vim.keymap.del("i", "<M-C-Right>")
end
