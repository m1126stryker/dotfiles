return {
  -- LSP plugins && setup here
  { "https://git.sr.ht/~p00f/clangd_extensions.nvim",
    { 'neovim/nvim-lspconfig',
      dependencies = { 
        { { 'hrsh7th/nvim-cmp', lazy = false },
          { 'hrsh7th/cmp-nvim-lsp', lazy = false },
          'j-hui/fidget.nvim',
          opts = {
            progress = { display = { render_limit = 7, }, },
          },
        },
      },
      config = function()
        local lspconfig = require('lspconfig')
        local telescope_bi = require('telescope.builtin')
        capabilities = require('cmp_nvim_lsp').default_capabilities()
        --[[require('cmp').setup {
          sources
        }]]--
        -- Global LSP keybinds
        local function lsp_global_keybinds(event)
          vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, { desc = 'Display Short decribtion for the symbol under cursor', buffer=event.buf })
          vim.keymap.set('n', '<leader>ren', vim.lsp.buf.rename, { desc = '[REN]ame symbol under cursor context wide -:wa to globally apply changes-', buffer=event.buf })
          vim.keymap.set('n', '<leader>gd', telescope_bi.lsp_definitions, { desc = '[G]oto [D]efinition', buffer=event.buf })
          vim.keymap.set('n', '<leader>gtd', telescope_bi.lsp_type_definitions, { desc = '[G]oto [T]ype [D]efinition', buffer=event.buf })
          vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration', buffer=event.buf })
          vim.keymap.set('n', '<leader>gr', telescope_bi.lsp_references, { desc = '[G]oto [R]eference', buffer=event.buf })
          vim.keymap.set('n', '<leader>gi', telescope_bi.lsp_implementations, { desc = '[G]oto [I]mplementation', buffer=event.buf })
          vim.keymap.set('n', '<leader>dl', telescope_bi.diagnostics, { desc = '[D]iagnostics [L]ist'}) --buffer=event.buf })
          vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, { desc = '[D]iagnostics [J](Down)Next', buffer=event.buf })
          vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, { desc = '[D]iagnostics [K](Up)Previous', buffer=event.buf })
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc ='[C]ode [A]ctions', buffer=event.buf })
        end
        
        --[[lspconfig.clangd.setup{
         require("clangd_extensions").setup  { 
            server = { 
              cmd = { "clangd",
                "--query-driver='/usr/bin/gcc'", 
              }, 
              on_attach = on_attach },
          },
          vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-on-attach', {clear = true}),
            callback = lsp_global_keybinds,
          }),
          capabilities = capabilites,
        }]]--
        lspconfig.ccls.setup{
          settings = {
            rootMarkers = {".ccls",".git/"},
            languages = {
              lua = {
                {formatCommand = "lua-format -i", formatStdin = true}
              }
            }
          },
          init_options = {
            documentFormatting = true;
            compilationDatabaseDirectory = "build";
            index = {
              threads = 0;
            };
            clang = {
              excludeArgs = { "-frounding-math"} ;
            };
          },
          vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-on-attach', {clear = true}),
            callback = lsp_global_keybinds,
          }),
          capabilities = capabilites
        }
        vim.api.nvim_create_autocmd('LspDetach', {
          callback = function()
            vim.lsp.buf.clear_references()
          end
        })
      end,
    },
  },
}
