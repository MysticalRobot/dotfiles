return {
	cmd = { 'lua_ls' },
	root_markers = { 'luarc.json' },
	filetypes = { 'lua' },
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
				}
				-- library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
}
