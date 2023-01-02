local fn = vim.fn

--[[
--  Install packer automatically
--]]

local install_path = fn.stdpath "data" .. "site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.vim",
    install_path,
  }
  print "Installing packer: close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end


--------

--[[
--  Autocommand that reloads neovim whenever you write plugins.lua file"
--]]

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]


--------

--[[
--  Initialize packer
--]]

local ok, packer = pcall(require, "packer")

if not ok then
  vim.notify("Failed to initialize packer. Exiting...")
  return
end

packer.init {
  display = {
    open_fn = function() 
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

------

--[[
--  Specify plugins for installation
--]]


return packer.startup(
  function (use)

    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    -- Colorschemes
    use "lunarvim/colorschemes"
    use "lunarvim/darkplus.nvim"
    use {
      "monsonjeremy/onedark.nvim",
      branch = "treesitter",
    }
    use "olimorris/onedarkpro.nvim"
    use "Mofiqul/dracula.nvim"

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"

    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/mason.nvim" -- language server installer
    use "williamboman/mason-lspconfig.nvim" -- configuration for mason installer
    use "jose-elias-alvarez/null-ls.nvim"

    use "karb94/neoscroll.nvim" -- smooth scroll

    use { 
      'nvim-lualine/lualine.nvim', -- status line
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end
)


