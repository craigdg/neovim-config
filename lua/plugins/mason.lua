local mason = require("mason")
local mason_lsp_config = require("mason-lspconfig")
local lsp_zero = require('lsp-zero')
local languages = { 'tsserver', 'eslint', 'lua_ls', 'bashls', 'gopls', 'taplo', 'jsonls', 'yamlls' }

mason.setup(languages)

mason_lsp_config.setup({
    ensure_installed = languages,
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
            })
        end,
    }
})
