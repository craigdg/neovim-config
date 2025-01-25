vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = "EnsureEmpty"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.sh" },
    command = "Shfmt"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.ts", "*.tsx", "*.js", "*.cjs", "*.yaml", "*.yml", "*.graphql", "*.gql", "*.graphqls" },
    command = "Prettier"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.lua", "*.toml", "*.go", "*.json", "*.go" },
    command = "LspZeroFormat"
})
