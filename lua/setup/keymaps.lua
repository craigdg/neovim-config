local builtin = require('telescope.builtin')

vim.keymap.set("t", "<Leader>;", function()
    vim.cmd('FocusFile')
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>;", function()
    vim.cmd('FocusTerminal')
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>o", function()
    vim.cmd('ChatGPT')
end, {
    noremap = true
})

vim.keymap.set("t", "<Leader>o", function()
    vim.cmd('ChatGPT')
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>k", function()
    vim.cmd('FloatingTerminal')
end, {
    noremap = true
})

vim.keymap.set("t", "<Leader>k", function()
    vim.cmd('FloatingTerminal')
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>g", function()
    vim.cmd('LazyGit')
end, {
    noremap = true
})

vim.keymap.set("t", "<Leader>g", function()
    vim.cmd('LazyGit')
end, {
    noremap = true
})

vim.keymap.set("t", "<Leader>b", function()
    vim.cmd('Btop')
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>b", function()
    vim.cmd('Btop')
end, {
    noremap = true
})

vim.keymap.set('t', '<Leader>\'', function()
    vim.cmd "TerminalNew"
end, {
    noremap = true
})

vim.keymap.set('n', '<Leader>\'', function()
    vim.cmd "TerminalNew"
end, {
    noremap = true
})

vim.keymap.set('t', '<Leader>/', function()
    vim.cmd "ToggleTerm"
end, {
    noremap = true
})

vim.keymap.set('n', '<Leader>/', function()
    vim.cmd "ToggleTerm"
end, {
    noremap = true
})

vim.keymap.set('t', '<Leader>#', function()
    vim.cmd "TermSelect"
end, {
    noremap = true
})

vim.keymap.set('n', '<Leader>#', function()
    vim.cmd "TermSelect"
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>d", function()
    vim.cmd "DiagnosticsToggle"
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>D", function()
    vim.cmd "DiagnosticsWorkspaceToggle"
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>E", function()
    vim.cmd "NvimTreeToggle"
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>e", function()
    vim.cmd "NvimTreeFocus"
end, {
    noremap = true
})

vim.keymap.set("t", "<Leader>E", function()
    vim.cmd "NvimTreeToggle"
end, {
    noremap = true
})

vim.keymap.set("t", "<Leader>e", function()
    vim.cmd "NvimTreeFocus"
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
