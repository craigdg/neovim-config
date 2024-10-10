local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lsp_zero = require('lsp-zero')
local lspconfig = require("lspconfig")

local languages = {
    'ts_ls',
    'eslint',
    'lua_ls',
    'bashls',
    'gopls',
    'taplo',
    'jsonls',
    'yamlls',
    'graphql'
}

mason.setup()

mason_lspconfig.setup({
    ensure_installed = languages,
    automatic_installation = true,
})

lsp_zero.extend_lspconfig()

lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

lsp_zero.default_setup()

for _, server in ipairs(languages) do
    if server == "lua_ls" then
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        })
    else
        lspconfig[server].setup({})
    end
end
