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
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
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
          init_selection = "<leader>is", -- set to `false` to disable one of the mappings
          node_incremental = "<leader>ni",
          scope_incremental = "<leader>si",
          node_decremental = "<leader>nd",
        },
      },
    },
    --enable folding [disabled for now]
    --init = function()
    --  vim.wo.foldmethod = 'expr'
    --  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    --end,
  },
  -- AUTOCOMPLETION PLUGINS
}
