return {
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				-- highlight all color codes in all files
				"*",
				-- optionally exclude certain filetypes or customise
				"!vim", -- example: don’t color in vimscript
			}, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = false, -- disable named colors like “Red” or “Blue”
				mode = "background", -- highlight by background by default
			})
		end,
	},
}
