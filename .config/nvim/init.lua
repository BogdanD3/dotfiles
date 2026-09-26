-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.loop or vim.uv).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("keymaps")

-- Setup lazy.nvim
require("vim-options")
require("lazy").setup("plugins", {
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})

-- Make Neovim background fully transparent
vim.cmd([[
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  hi SignColumn guibg=NONE ctermbg=NONE
  hi VertSplit guibg=NONE ctermbg=NONE
  hi StatusLine guibg=NONE ctermbg=NONE
  hi StatusLineNC guibg=NONE ctermbg=NONE
  hi NeoTreeNormal guibg=NONE
  hi NeoTreeNormalNC guibg=NONE
  hi LineNr guifg=#743dad guibg=NONE
]])
