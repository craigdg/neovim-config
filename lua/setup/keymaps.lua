local builtin = require('telescope.builtin')

-- Chat GPT (Personal only)

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

-- Previous file

vim.keymap.set("n", "<leader>,", function()
    vim.cmd('bp')
end, {
    noremap = true,
})

vim.keymap.set("n", "<leader>.", function()
    vim.cmd('bn')
end, {
    noremap = true,
})

-- Clear search

vim.keymap.set("n", "<leader>z", function()
    vim.cmd('nohlsearch')
end, {
    noremap = true,
    silent = true
})

-- Split window

vim.keymap.set("n", "<Leader>v", function()
    vim.cmd('Split')
end, {
    noremap = true
})

-- Generic floating terminal

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

-- LazyGit floating terminal

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

-- Btop floating terminal

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

-- Focus file

vim.keymap.set("n", "<Leader>f", function()
    vim.cmd('FocusFile')
end, {
    noremap = true
})

vim.keymap.set("t", "<Leader>f", function()
    vim.cmd('FocusFile')
end, {
    noremap = true
})

-- Close quickfix

vim.keymap.set("n", "<Leader>q", function()
    vim.cmd('cclose')
end, {
    noremap = true
})

vim.keymap.set("t", "<Leader>q", function()
    vim.cmd('cclose')
end, {
    noremap = true
})

-- New terminal

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

-- Terminal toggle

vim.keymap.set('t', '<Leader>/', function()
    vim.cmd "TerminalToggle"
end, {
    noremap = true
})

vim.keymap.set('n', '<Leader>/', function()
    vim.cmd "TerminalToggle"
end, {
    noremap = true
})

-- Terminal select

vim.keymap.set('t', '<Leader>;', function()
    vim.cmd "TermSelect"
end, {
    noremap = true
})

vim.keymap.set('n', '<Leader>;', function()
    vim.cmd "TermSelect"
end, {
    noremap = true
})

-- Diagnostics toggle

vim.keymap.set("n", "<Leader>d", function()
    vim.cmd "DiagnosticsToggle"
end, {
    noremap = true
})

vim.keymap.set("t", "<Leader>d", function()
    vim.cmd "DiagnosticsToggle"
end, {
    noremap = true
})

vim.keymap.set("n", "<Leader>D", function()
    vim.cmd "DiagnosticsWorkspaceToggle"
end, {
    noremap = true
})

-- Nvim tree toggle

vim.keymap.set("n", "<Leader>e", function()
    vim.cmd "NvimTreeOpen"
end, {
    noremap = true
})

vim.keymap.set("t", "<Leader>e", function()
    vim.cmd "NvimTreeOpen"
end, {
    noremap = true
})

-- Telescope builtins

vim.keymap.set('n', '<Leader>l', builtin.buffers, {
    noremap = true,
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
