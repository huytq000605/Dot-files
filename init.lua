-- Set options
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.encoding = 'UTF-8'
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wildmode = 'longest,list'
vim.cmd('syntax enable')

-- Enable termguicolors
vim.opt.termguicolors = true


-- Indentation and tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Mouse
vim.opt.mouse = 'a'

-- Incremental search
vim.opt.incsearch = true

-- Filetype, plugin, and indent settings
vim.cmd('filetype plugin indent on')

-- Cursorline, wrap, auto-indent, termguicolors
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.ai = true
vim.opt.termguicolors = true

-- Uncomment the line below if you want to enable inccommand with 'split'
-- vim.opt.inccommand = 'split'

-- Map leader key
vim.g.mapleader = " "

-- Clipboard settings
vim.opt.clipboard = 'unnamed'

-- Rainbow color
vim.g.rainbow_active = 1

-- Highlight function in Golang
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1

-- Auto-start Coq.nvim
-- vim.g.coq_settings = { auto_start = true, keymap = { jump_to_mark = nil } }

-- Lazy.nvim Installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim Initialization
plugins = {
    -- VSCode extension check
    {'asvetliakov/vim-easymotion'},
    'shaunsingh/moonlight.nvim',
    {
     'nvim-tree/nvim-tree.lua', 
      version = "*", 
      lazy = false, 
      dependencies = {"nvim-tree/nvim-web-devicons"},
      config = function()
        require("nvim-tree").setup {
          view = {
            relativenumber = true
          }
        }
      end
    },
    {'phaazon/hop.nvim', config = function() 
      require("hop").setup({
        keys = 'abcdefghijklmnopqrstuvwxyz'
      })
      vim.keymap.set('n', 's', function()
        require("hop").hint_char1({})
      end, {})
    end
    },
    { 'nvim-telescope/telescope.nvim', 
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {'nvim-telescope/telescope-fzf-native.nvim', build = function() vim.fn['make']() end},
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    'neovim/nvim-lspconfig',
    {'windwp/nvim-autopairs', config = function() require("nvim-autopairs").setup{} end },
}
require("lazy").setup(plugins)

-- Set colorscheme
vim.cmd('colorscheme moonlight')

-- Key mappings for Nvim Tree
vim.api.nvim_set_keymap('n', '<C-q>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
-- Uncomment the following lines if you need more Nvim Tree key mappings
-- vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
-- ...


-- Key mapping
-- "c" and "d" don't use buffer register
vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true })
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true })
vim.api.nvim_set_keymap('v', 'd', '"_d', { noremap = true })
vim.api.nvim_set_keymap('n', 'c', '"_c', { noremap = true })
vim.api.nvim_set_keymap('v', 'c', '"_c', { noremap = true })
vim.api.nvim_set_keymap('v', 'p', '"_dP', { noremap = true })

vim.api.nvim_set_keymap('n', 'Q', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('i', '<c-a>', '<Nop>', { noremap = true })

vim.api.nvim_set_keymap('i', ',', ',<c-g>u', { noremap = true })
vim.api.nvim_set_keymap('i', '.', '.<c-g>u', { noremap = true })
vim.api.nvim_set_keymap('i', '!', '!<c-g>u', { noremap = true })
vim.api.nvim_set_keymap('i', '?', '?<c-g>u', { noremap = true })

-- "begin" and "end" on line in normal, visual, operation"
vim.api.nvim_set_keymap('n', 'B', '^', { noremap = true })
vim.api.nvim_set_keymap('v', 'B', '^', { noremap = true })
vim.api.nvim_set_keymap('o', 'B', '^', { noremap = true })
vim.api.nvim_set_keymap('n', 'E', '$', { noremap = true })
vim.api.nvim_set_keymap('v', 'E', '$', { noremap = true })
vim.api.nvim_set_keymap('o', 'E', '$', { noremap = true })

vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

vim.api.nvim_set_keymap('n', '<space>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-space>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-[>', ':-tabmove<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-]>', ':+tabmove<cr>', { noremap = true })



-- Telescope --------------------------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.find_files, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p', builtin.live_grep, { noremap = true, silent = true })
vim.keymap.set('n', '<c-b>', builtin.buffers, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { noremap = true, silent = true })

-- LSP ---------------------------------------------
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.api.nvim_set_keymap('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.api.nvim_set_keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.api.nvim_set_keymap('n', '<c-space>', vim.lsp.buf.hover, bufopts)
  vim.api.nvim_set_keymap('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.api.nvim_set_keymap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.api.nvim_set_keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.api.nvim_set_keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.api.nvim_set_keymap('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.api.nvim_set_keymap('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.api.nvim_set_keymap('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.api.nvim_set_keymap('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.api.nvim_set_keymap('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.api.nvim_set_keymap('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"gopls"}
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
  }
end

-- If using WSL, download win32yank and put it in the directory, then use these configs to sync buffer
-- local win32yank = '/usr/local/bin/win32yank.exe'
-- vim.g.clipboard = {
--     name = 'wsl',
--     copy = {
--         ['+'] = win32yank .. ' -i --crlf',
--         ['*'] = win32yank .. ' -i --crlf',
--     },
--     paste = {
--         ['+'] = win32yank .. ' -o --lf',
--         ['*'] = win32yank .. ' -o --lf',
--     },
-- }

-- Uncomment the above lines if you're using WSL and have win32yank installed.
