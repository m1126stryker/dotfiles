return {
  {'norcalli/nvim-colorizer.lua',
    lazy = false,
    init = function()
      require 'colorizer'.setup(
        {'css';
         'html';},
        { mode = 'foreground'; })
    end
  },
  { "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp"
  },
  { 'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline',
        'bash', 'diff', 'html', 'luadoc' },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { 
        enable = true,
        disable = { 'ruby' },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<leader>is',
          node_incremental = '<leader>ni',
          scope_incremental = '<leader>si',
          node_decremental = '<leader>nd',
        },
      },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            ['af'] = { query = '@function.outer', desc = 'Select [A]round a [F]unction' },
            ['if'] = { query = '@function.inner', desc = 'Select [I]nner part of a [F]unction' },
            ['al'] = { query = '@loop.outer', desc = 'Select [A]round a [L]oop' },
            ['il'] = { query = '@loop.inner', desc = 'Select [I]nner part of a [L]oop' },
            ['ac'] = { query = '@class.outer', desc = 'Select [A]round a [C]lass region' },
            ['ic'] = { query = '@class.inner', desc = 'Select [I]nner part of a [C]lass region' },
            ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'v', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = true,
        },
      },
    },
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  { 'hrsh7th/nvim-cmp',
    dependencies = {
      { 'L3MON4D3/LuaSnip', lazy = false },
      { 'saadparwaiz1/cmp_luasnip', lazy = false },
    },
    config = function()
      vim.opt.completeopt = {"menu", "menuone", "noinsert"}
    end,
  },
  { 'hrsh7th/cmp-buffer', 
    dependencies = {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'neovim/nvim-lspconfig',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-s>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true })
        }),
        sources = {
          { name = 'nvim_lsp' , priority = 2 },
          { name = 'luasnip' , priority = 1 },
          { name = 'path' , priority = 3 },
          { name = 'buffer', priority = 4 }
        } 
      })
    end
  },
}
