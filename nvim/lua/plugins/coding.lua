return {
-- AUTOCOMPLETION PLUGINS
  {'norcalli/nvim-colorizer.lua',
    lazy = false,
    init = function()
      require 'colorizer'.setup(
        {'css';
         'html';},
        { mode = 'foreground'; })
    end
  },
}
