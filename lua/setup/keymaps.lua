local builtin = require('telescope.builtin')

vim.keymap.set("t", "<Leader>;", function()
    vim.cmd('FocusFile')
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>g", function()
    vim.cmd('LazyGit')
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>;", function()
    vim.cmd('FocusTerminal')
end, {
    noremap = true
})

vim.keymap.set('n', '<Leader>#', function()
    vim.cmd "TerminalNew"
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>\'", function()
    vim.cmd "TerminalToggleSizing"
end, {
    noremap = true
})

vim.keymap.set('n', '<Leader>/', function()
    vim.cmd "TerminalToggle"
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>d", function()
    vim.cmd "DiagnosticsToggle"
    vim.cmd("setlocal wrap")
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>D", function()
    vim.cmd "DiagnosticsWorkspaceToggle"
    vim.cmd("setlocal wrap")
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>e", function()
    vim.cmd "NvimTreeToggle"
end, {
    noremap = true
})

vim.keymap.set('n', '<Leader>p', builtin.find_files, {
    noremap = true,
})

vim.keymap.set('n', '<Leader>s', builtin.live_grep, {
    noremap = true,
})

vim.keymap.set('n', '<Leader>S', builtin.grep_string, {
    noremap = true,
})

vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {
    noremap = true,
})

vim.keymap.set('n', '<Leader>,', '<Cmd>BufferPrevious<CR>', {
    noremap = true,
})

vim.keymap.set('n', '<Leader>.', '<Cmd>BufferNext<CR>', {
    noremap = true,
})
