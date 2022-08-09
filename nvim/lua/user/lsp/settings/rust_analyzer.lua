return {
	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
	-- https://rust-analyzer.github.io/manual.html#features
	settings = {
		["rust-analyzer"] = {
			assist = {
				importEnforceGranularity = true,
				importPrefix = "crate",
			},
			cargo = {
				allFeatures = true,
			},
			checkOnSave = {
				-- default: `cargo check`
				command = "clippy",
			},
		},
		inlayHints = {
			lifetimeElisionHints = {
				enable = true,
				useParameterNames = true,
			},
		},
	},
}
