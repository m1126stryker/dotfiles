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
            -- You can use the capture groups defined in textobjects.scm
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
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = true,
        },
      },
    },
    --enable folding [disabled for now]
    --init = function()
    --  vim.wo.foldmethod = 'expr'
    --  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    --end,
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  -- AUTOCOMPLETION PLUGINS
}
