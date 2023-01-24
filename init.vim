set showmatch
set hlsearch
set ignorecase
set smartcase
set showcmd
set showmode
set encoding=UTF-8
set relativenumber
set number
set wildmode=longest,list
syntax on 
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set mouse=a
set incsearch
"set cc=80
filetype plugin indent on
set cursorline
set wrap
set ai
set termguicolors
"set inccommand=split
let mapleader =" "
set clipboard=unnamed

" rainbow color
let g:rainbow_active = 1

" highlight function golang
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

" auto start coq nvim
let g:coq_settings = { 'auto_start': v:true }

call plug#begin()
if exists('g:vscode')
  Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
  " VSCode extension
else
  " ordinary neovim
  Plug 'shaunsingh/moonlight.nvim'
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'easymotion/vim-easymotion'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'windwp/nvim-autopairs'
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
endif

" use normal easymotion when in vim mode
" use vscode easymotion when in vscode mode
call plug#end()

colorscheme moonlight

if exists('g:vscode')

else
  
" Nvim Tree
lua<<EOF
require'nvim-tree'.setup {}
require'nvim-tree.view'.View.winopts.relativenumber = true
EOF

nnoremap <C-q> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
"nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose and NvimTreeFocus are also available if you need them
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set termguicolors " this variable must be enabled for colors to be applied properly
endif

" Easy motion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
"map s <Plug>(easymotion-bd-w)
nmap s <Plug>(easymotion-bd-f)
""""""""""""""""""""""""""""""""""""""""""""""""

"c and d dont use buffer register
nnoremap x "_x
nnoremap d "_d
vnoremap d "_d
nnoremap c "_c
vnoremap c "_c
vnoremap p "_dP

nnoremap Q <Nop>
inoremap <c-a> <Nop>

inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" begin and end on line in normal, visual, operation
nnoremap B ^
vnoremap B ^
onoremap B ^
nnoremap E $
vnoremap E $
onoremap E $

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
tnoremap <Esc> <C-\><C-n>


nnoremap <space> <Nop>
nnoremap <c-space> <Nop>
nnoremap <C-[> :-tabmove<cr>
nnoremap <C-]> :+tabmove<cr>

lua<<EOF

-- Telescope --------------------------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>p', builtin.live_grep, {})
vim.keymap.set('n', '<c-b>', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-----------------------------------------------------

-- LSP ---------------------------------------------
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<c-space>', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"gopls"}
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
  }
end
-- --------------------------------------------------------------------------------------

EOF

" If using WSL, download win32yank and put in dir, then using these configs to sync buffer
" let s:win32yank = '/usr/local/bin/win32yank.exe'
" let g:clipboard = {
"       \  'name' : 'wsl',
"       \  'copy' : {
"       \    '+' : s:win32yank..' -i --crlf',
"       \    '*' : s:win32yank..' -i --crlf',
"       \  },
"       \  'paste' : {
"       \    '+' : s:win32yank..' -o --lf',
"       \    '*' : s:win32yank..' -o --lf',
"       \  },
"       \}
" unlet s:win32yank
