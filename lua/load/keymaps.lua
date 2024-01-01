local builtin = require('telescope.builtin')

vim.keymap.set("n", "<Leader>f", function()
    vim.cmd "Ag"
end)

vim.keymap.set("n", "<Leader>p", function()
    vim.cmd "Files"
end)

vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]], { noremap = true })

vim.keymap.set('n', '<Leader>t', function()
    vim.cmd "TerminalNew"
end)

vim.keymap.set('n', '<Leader>r', function()
    vim.cmd "TerminalToggle"
end)

vim.keymap.set("n", "<Leader>d", function()
    vim.cmd "DiagnosticsToggle"
end)

vim.keymap.set("n", "<Leader>e", function()
    vim.cmd "NvimTreeToggle"
end)

vim.keymap.set("n", "<Leader><Space>", function()
    vim.cmd "TerminalToggleSizing"
end)

vim.keymap.set('n', '<leader>p', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {
    noremap = true,
    silent = true
})
