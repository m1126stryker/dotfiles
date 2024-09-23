return {
-- Install colorschemes
  { 'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
      vim.api.nvim_set_hl(0, 'StatusLine', {fg='#15161e', bg='#7aa2f7'}) 
    end,
    opts = {
      dim_inactive = true
    }
  },
}
