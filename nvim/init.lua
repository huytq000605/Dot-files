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
-- vim.cmd('filetype plugin indent on')

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
    -- {'asvetliakov/vim-easymotion'},
    {'shaunsingh/moonlight.nvim', config = function() 
        -- Set colorscheme
        vim.cmd('colorscheme moonlight')
      end
    },
    {'nvim-tree/nvim-tree.lua', 
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
      dependencies = { 
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        "nvim-tree/nvim-web-devicons"
      },
      config = function()
        require("telescope").load_extension("fzf")

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<c-p>', builtin.find_files, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>p', builtin.live_grep, { noremap = true, silent = true })
        vim.keymap.set('n', '<c-b>', builtin.buffers, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { noremap = true, silent = true })
      end
    },
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    { 'neovim/nvim-lspconfig',
      dependencies = {
        "hrsh7th/cmp-nvim-lsp"
      },
      config = function() 
        local opts = { noremap = true, silent = true }

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Disable ctrl space in insert mode
        vim.keymap.set('i', '<c-space>', "<Nop>", bufopts)

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)

          -- Mappings
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          bufopts.desc = "Go to declaration"
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)

          bufopts.desc = "Show definitions"
          vim.keymap.set('n', 'gd', "<cmd>Telescope lsp_definitions<CR>", bufopts)

          -- bufopts.desc = "Hover"
          vim.keymap.set('n', '<c-space>', vim.lsp.buf.hover, bufopts)


          -- bufopts.desc = "Show implementations"
          -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
          vim.keymap.set('n', 'gi', "<cmd>Telescope lsp_implementations<CR>", bufopts)

          bufopts.desc = "Show LSP references"
          vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

          vim.keymap.set('n', '<space>f', function() 
            vim.lsp.buf.format { async = true }
          end, bufopts)
        end

        -- Use a loop to conveniently call 'setup' on multiple servers and
        -- map buffer local keybindings when the language server attaches
        local servers = {"gopls", "pyright"}
        for _, lsp in ipairs(servers) do
          require('lspconfig')[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities
          }
        end


        -- Highlight function in Golang
        vim.g.go_highlight_functions = 1
        vim.g.go_highlight_function_calls = 1
    end
    },
    {'windwp/nvim-autopairs', config = function() require("nvim-autopairs").setup{} end },
    {"hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        "L3MON4D3/LuaSnip", -- snippet engine
        "saadparwaiz1/cmp_luasnip", -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim", -- vs-code like pictograms
      },
      config = function()
        local cmp = require("cmp")

        local luasnip = require("luasnip")

        local lspkind = require("lspkind")

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        vim.keymap.set('i', '<Nop>', vim.lsp.buf.hover, bufopts)


        cmp.setup({
          completion = {
            completeopt = "menu,menuone,preview,noselect",
          },
          snippet = { -- configure how nvim-cmp interacts with snippet engine
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<s-tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
            ["<tab>"] = cmp.mapping.select_next_item(), -- next suggestion
            -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
            -- ["<C-space>"] = cmp.mapping.complete(), -- show completion suggestions
            -- ["<C-e>"] = cmp.mapping.abort(), -- close completion window
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
          }),
          -- sources for autocompletion
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" }, -- snippets
            { name = "buffer" }, -- text within current buffer
            { name = "path" }, -- file system paths
          }),
          -- configure lspkind for vs-code like pictograms in completion menu
          formatting = {
            format = lspkind.cmp_format({
              -- maxwidth = 50,
              ellipsis_char = "...",
            }),
          },
        })
      end
    }
}
require("lazy").setup(plugins)

-- Key mappings for Nvim Tree
vim.keymap.set('n', '<C-q>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
-- Uncomment the following lines if you need more Nvim Tree key mappings
-- vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })


-- Key mapping
-- "c" and "d" don't use buffer register
vim.keymap.set('n', 'x', '"_x', { noremap = true })
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('v', 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'c', '"_c', { noremap = true })
vim.keymap.set('v', 'c', '"_c', { noremap = true })
vim.keymap.set('v', 'p', '"_dP', { noremap = true })

vim.keymap.set('n', 'Q', '<Nop>', { noremap = true })
vim.keymap.set('i', '<c-a>', '<Nop>', { noremap = true })

vim.keymap.set('i', ',', ',<c-g>u', { noremap = true })
vim.keymap.set('i', '.', '.<c-g>u', { noremap = true })
vim.keymap.set('i', '!', '!<c-g>u', { noremap = true })
vim.keymap.set('i', '?', '?<c-g>u', { noremap = true })

-- "begin" and "end" on line in normal, visual, operation"
vim.keymap.set('n', 'B', '^', { noremap = true })
vim.keymap.set('v', 'B', '^', { noremap = true })
vim.keymap.set('o', 'B', '^', { noremap = true })
vim.keymap.set('n', 'E', '$', { noremap = true })
vim.keymap.set('v', 'E', '$', { noremap = true })
vim.keymap.set('o', 'E', '$', { noremap = true })

-- moving between buffers
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })


-- ESC key in terminal, remove ESC keybinding in normal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('n', '<Esc>', '<Nop>', { noremap = true })

vim.keymap.set('n', '<space>', '<Nop>', { noremap = true })
vim.keymap.set('n', '<c-space>', '<Nop>', { noremap = true })
vim.keymap.set('n', '<C-[>', ':-tabmove<cr>', { noremap = true })
vim.keymap.set('n', '<C-]>', ':+tabmove<cr>', { noremap = true })



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
