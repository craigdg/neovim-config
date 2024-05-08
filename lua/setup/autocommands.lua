local panes = require("panes.index")

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    command = "Setup"
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = "EnsureEmpty"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.sh" },
    command = "Shfmt"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.yaml", "*.yml", "*.graphql", "*.gql", "*.graphqls" },
    command = "Prettier"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.ts", "*.tsx", "*.js", "*.cjs", "*.lua", "*.toml", "*.go", "*.json", "*.go" },
    command = "LspZeroFormat"
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.defer_fn(function()
            if panes.terminal.is(vim.fn.expand('%')) then
                vim.cmd('startinsert')
            end
        end, 0)
    end
})
