function Color(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    -- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "SpecialKey", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

Color()
