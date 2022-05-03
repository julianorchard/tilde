return require('packer').startup(
  function()

-- Packer Nvim
    use {
      'wbthomason/packer.nvim'
    }

-- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter'
    }

-- Org Mode
    use {
      'nvim-orgmode/orgmode', config = function()
        require('orgmode').setup {}
      end
    }
    use {
      "akinsho/org-bullets.nvim", config = function()
        require("org-bullets").setup {
          symbols = { "◉", "○", "✸", "✿" }
        }
      end
    }

-- Nvim Tree
    use {
      'kyazdani42/nvim-tree.lua', config = function()
        require('kyazdani42/nvim-web-devicons').setup{}
      end
    }

------ Vim Converted ------ ~
   -- Apperance
    use {
      'flazz/vim-colorschemes'
    }
    use {
      'itchyny/lightline.vim'
    }
    use {
      'junegunn/goyo.vim'
    }
    use {
      'junegunn/limelight.vim'
    }
    use {
      'lambdalisue/battery.vim'
    }
    use {
      'rakr/vim-two-firewatch'
    }
  -- Text Manipulation 
    use {
      'tpope/vim-commentary'
    }
  -- Navigation 
    use {
      'Xuyuanp/nerdtree-git-plugin'
    }
    use {
      'junegunn/fzf'
    }
    use {
      'junegunn/fzf.vim'
    }
  -- Other
    use {
      'julianorchard/desc.vim'
    }

  end
)
