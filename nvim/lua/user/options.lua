local options = {
    tabstop = 2,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,
    relativenumber = true,
    number = true,
    scrolloff = 10,
    mouse = "a",
    incsearch = true,
    signcolumn = "yes",
    showmode = false,
    updatetime = 100,
    undofile = true
}

for k,v in pairs(options) do
    vim.opt[k] = v
end

