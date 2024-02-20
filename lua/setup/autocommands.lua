local panes = require("panes.index")

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    command = "Setup"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.sh" },
    command = "Shfmt"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.yaml", "*.yml" },
    command = "Prettier"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.ts", "*.tsx", "*.js", "*.cjs", "*.lua", "*.toml", "*.go", "*.json" },
    command = "LspZeroFormat"
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.defer_fn(function()
            panes.file.ensure()
            panes.terminal.resize()
        end, 0)
    end
})
