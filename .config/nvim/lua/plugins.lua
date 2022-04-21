return require('packer').startup(function()

-- Lua Specific
  use 'wbthomason/packer.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use {'nvim-orgmode/orgmode', config = function()
    require('orgmode').setup{}
  end}

-- Vim Converted
   -- Apperance
      use 'flazz/vim-colorschemes'
      use 'itchyny/lightline.vim'
      use 'junegunn/goyo.vim'
      use 'junegunn/limelight.vim'
      use 'lambdalisue/battery.vim'
      use 'rakr/vim-two-firewatch'
    -- Org-Like   
      use 'mattn/vim-gist'
      use 'mattn/webapi-vim'
    -- Text Manipulation 
      use 'tpope/vim-commentary'
      use 'tpope/vim-surround'
      use 'dhruvasagar/vim-table-mode'
      use 'mg979/vim-visual-multi'
    -- Navigation 
      use 'Xuyuanp/nerdtree-git-plugin'
      use 'junegunn/fzf'
      use 'junegunn/fzf.vim'
      use 'preservim/nerdtree'
      use 'ryanoasis/vim-devicons'
    -- Language
      use 'dense-analysis/ale'
      use 'pprovost/vim-ps1'
      use 'tpope/vim-rails'
    -- Other
      use 'julianorchard/desc.vim'
      use 'mattn/vim-notification'

end)
