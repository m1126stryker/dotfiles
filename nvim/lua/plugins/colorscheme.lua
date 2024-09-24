return {
-- Install colorschemes
  { "catppuccin/nvim",
    name = "catppuccin", 
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
      vim.cmd.hi 'Comment gui=none'
    end,
    opts = {
      flavour = 'mocha',
      --transparent_background = true,
      dim_inactive = {
        enabled = true,
        shade = 'dark',
        precentage = 0.5,
      },
    },
  },
}
