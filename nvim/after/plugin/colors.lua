function Color(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    -- vim.cmd([[
    --     hi Normal guibg=none ctermbg=none
    --     hi LineNr guibg=none ctermbg=none
    --     hi Folded guibg=none ctermbg=none
    --     hi NonText guibg=none ctermbg=none
    --     hi SpecialKey guibg=none ctermbg=none
    --     hi VertSplit guibg=none ctermbg=none
    --     hi SignColumn guibg=none ctermbg=none
    --     hi EndOfBuffer guibg=none ctermbg=none
    --     hi! link NormalFloat Normal
    -- ]])
end

Color()
