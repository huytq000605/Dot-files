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
set so=999
set cursorline
set nowrap
set ai
set termguicolors
let mapleader =" "


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
endif



" use normal easymotion when in vim mode
" use vscode easymotion when in vscode mode
call plug#end()

colorscheme moonlight

if exists('g:vscode')

else
  "		" Set completeopt to have a better completion experience
  "		set completeopt=menuone,noinsert,noselect
  "
  "		" Avoid showing message extra message when using completion
  "		set shortmess+=c

  " Tree
  nnoremap <C-q> :NvimTreeToggle<CR>
  nnoremap <leader>r :NvimTreeRefresh<CR>
  "nnoremap <leader>n :NvimTreeFindFile<CR>
  " NvimTreeOpen, NvimTreeClose and NvimTreeFocus are also available if you need them

  set termguicolors " this variable must be enabled for colors to be applied properly

  " Telescope
  nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
  nnoremap <leader>p <cmd>lua require('telescope.builtin').live_grep()<cr>
  nnoremap <C-b> <cmd>lua require('telescope.builtin').buffers()<cr>
  nnoremap gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
  nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
  "nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

  "
endif

let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:rainbow_active = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings

"map  s <Plug>(easymotion-bd-w)
nmap s <Plug>(easymotion-bd-f)

"c and d dont use buffer register
nnoremap x "_x
nnoremap d "_d
vnoremap d "_d
nnoremap c "_c
vnoremap c "_c
vnoremap p "_dP

nnoremap Q <Nop>
inoremap <c-a> <Nop>

" When press next move to center screen
" nnoremap j jzz
" nnoremap k kzz
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap J mzJ`z
" nnoremap G Gzz
" nnoremap gg ggzz
" nnoremap <C-d> <C-d>zz
" nnoremap <C-y> <C-y>zz

inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" move line up down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

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

lua<<EOF
require'nvim-tree'.setup {}
require'nvim-tree.view'.View.winopts.relativenumber = true

EOF

lua<<EOF
local nvim_lsp = require('lspconfig')
require'lspconfig'.solargraph.setup{}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<c-space>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --[[
  buf_set_keymap('n', '<c-space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  --]]

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {'solargraph'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
