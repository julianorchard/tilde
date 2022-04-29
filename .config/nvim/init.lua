-- Plugins
require('plugins')

-- Vim Commands:
--    - ColourScheme
--    - LightLine
--    - Desc.vim
vim.cmd([[

  color two-firewatch

  let g:lightline = {
    \ 'colorscheme': 'Tomorrow',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified', 'battery' ] ]
    \ },
    \ 'component_function': {
    \   'battery': 'battery#component',
    \ }
  \}

  let g:desc_author = "Julian Orchard <hello@julianorchard.co.uk"

]])

-- Map Functions
-- From https://www.notonlycode.org/neovim-lua-config/
  function map(mode, s, c)
    vim.api.nvim_set_keymap(mode, s, c, { noremap = true, silent = true })
  end
  function nmap(s, c)
    map('n', s, c)
  end
  function vmap(s, c)
    map('v', s, c)
  end

-- Options
  vim.g.mapleader = ","
  vim.opt.encoding = "UTF-8"
  vim.opt.history = 1000
  vim.opt.wrap = true
  vim.opt.textwidth = 80
  vim.opt.scrolloff = 13
  vim.opt.autoindent = true
  vim.opt.smartindent = true
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.clipboard = "unnamedplus"

-- Tabbing Opts/Binds  
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  vmap("<tab>",">vgv")
  vmap("<s-tab>","<vgv")

-- Graphical Up/Down
  nmap("j","gj")
  nmap("k","gk")

-- Easier Split Navigation
  nmap("<c-j>", "<c-w>j")
  nmap("<c-k>", "<c-w>k")
  nmap("<c-l>", "<c-w>l")
  nmap("<c-h>", "<c-w>h")

-- Orgmode
  require('orgmode').setup_ts_grammar()
  -- Tree-sitter configuration
  require'nvim-treesitter.configs'.setup {
    -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
    highlight = {
      enable = true,
      disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
      additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
    },
    ensure_installed = {'org'}, -- Or run :TSUpdate org
  }
  require('orgmode').setup({
    org_agenda_files = {'~/Documents/org/*'},
    org_default_notes_file = '~/Documents/org/refile.org',
  })

