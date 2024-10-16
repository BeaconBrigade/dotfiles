local lsp = require('lsp-zero')

local lsp_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>gr', ':Telescope lsp_references<CR>', opts)
    vim.keymap.set('n', '<leader>gn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n', '<leader>gh', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>gws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
end

lsp.extend_lspconfig({
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    lsp_attach = lsp_attach,
    float_border = 'rounded',
    sign_text = true,
})

local lspconfig = require('lspconfig')
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'rust_analyzer', 'clangd' },
    handlers = {
        ['lua_ls'] = function()
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })
        end,
        ['rust_analyzer'] = function()
            lspconfig.rust_analyzer.setup({
                settings = {
                    ['rust-analyzer'] = {
                        imports = {
                            prefix = 'crate',
                        },
                        check = {
                            command = 'clippy',
                        }
                    }

                }
            })
        end,
        function(server_name)
            lspconfig[server_name].setup({})
        end
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-K>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-J>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

cmp.setup({
    mapping = cmp_mappings,
    sources = cmp.config.sources({
        { name = 'nvim_lsp', },
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'path' },
    }),
    formatting = require('lsp-zero').cmp_format(),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    }
})
