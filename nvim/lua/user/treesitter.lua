local configs = require("nvim-treesitter.configs")
configs.setup {
  ensure_installed = {
      "c", 
      "lua", 
      "rust", 
      "java", 
      "javascript", 
      "css", 
      "html", 
      "json", 
      "markdown", 
      "python", 
      "vim" 
    },
  sync_install = false, 
  auto_install = true,
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml" } },
}
