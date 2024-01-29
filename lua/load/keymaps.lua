local builtin = require('telescope.builtin')

vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]], { noremap = true })

vim.keymap.set('n', '<Leader>t', function()
    vim.cmd "TerminalNew"
end)

vim.keymap.set('n', '<Leader>r', function()
    vim.cmd "TerminalToggle"
end)

vim.keymap.set("n", "<Leader>d", function()
    vim.cmd "DiagnosticsToggle"
    vim.cmd("setlocal wrap")
end)

vim.keymap.set("n", "<Leader>x", function()
    vim.cmd "DiagnosticsWorkspaceToggle"
    vim.cmd("setlocal wrap")
end)

vim.keymap.set("n", "<Leader>e", function()
    vim.cmd "NvimTreeToggle"
end)

vim.keymap.set("n", "<Leader><Space>", function()
    vim.cmd "TerminalToggleSizing"
end)

vim.keymap.set('n', '<Leader>p', builtin.find_files, {})
vim.keymap.set('n', '<Leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<Leader>b', builtin.buffers, {})
vim.keymap.set('n', '<Leader>h', builtin.help_tags, {})
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {
    noremap = true,
    silent = true
})
vim.keymap.set('n', '<Leader>,', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>.', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
