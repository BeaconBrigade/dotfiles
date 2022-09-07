local status_ok, tw_highlight = pcall(require, "tailwind-highlight")
if not status_ok then
	return
end

return {
	on_attach = function(client, bufnr)
		tw_highlight.setup(client, bufnr, {
			single_column = false,
			mode = "background",
			debounce = 200,
		})
		require("user.lsp.handlers").on_attach(client, bufnr)
	end,
}
