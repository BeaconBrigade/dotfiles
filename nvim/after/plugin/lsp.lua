local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'sumneko_lua',
    'rust_analyzer',
    'pyright',
})

lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.configure('rust-analyzer', {
    settings = {
        ['rust-analyzer'] = {
            imports = {
                prefix = 'crate',
            },
            checkOnSave = {
                command = 'clippy',
            }
        }
    }
})

lsp.nvim_workspace({
    library = vim.api.nvim_get_runtime_file('', true)
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<S-Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-K>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-J>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})
lsp.setup_nvim_cmp(cmp_mappings)

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>gr', ':Telescope lsp_references<CR>', opts)
    vim.keymap.set('n', '<leader>gn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n', '<leader>gh', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>gws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<leader>gl', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
end)

lsp.setup()
