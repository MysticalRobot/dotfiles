-- [[ options ]]
vim.g.mapleader = ' '           -- specify the key used as <leader>
vim.g.have_nerd_font = true     -- use nerd font
vim.o.spelllang = 'en'          -- enable spell checking for english
vim.o.winborder = 'rounded'     -- rounded border to floating windows
vim.o.number = true             -- show line numbers
vim.o.relativenumber = false    -- make line numbers relative
vim.o.wrap = false              -- diable line wrapping
vim.o.mouse = 'a'               -- enable mouse mode
vim.o.clipboard = 'unnamedplus' -- sync OS and nvim clipboards
vim.o.undofile = true           -- save undo history
vim.o.ignorecase = true         -- case-insenstive searching
vim.o.smartcase = true          -- case-sensitive searching if /C or >= 1 capital letters are used
vim.o.signcolumn = 'yes'        -- show sign column
vim.o.inccommand = 'split'      -- preview substitutions while typing
vim.o.cursorline = true         -- show the line your cursor is on
vim.o.scrolloff = 10            -- minimum number of screen lines aboes and below the cursor
vim.o.expandtab = true          -- use spaces for indentation
vim.o.shiftwidth = 2            -- use 2 spaces for indentation
vim.o.tabstop = 2               -- insert 2 spaces by hitting tab
vim.o.confirm = true            -- raise a dialog to confirm the handling of unsaved changes
vim.o.termguicolors = true      -- use true colors


-- [[ plugins ]]
vim.pack.add{
  -- directory of language server quickstart configurations
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  -- theme
  -- { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
  { src = 'https://github.com/neanias/everforest-nvim' },
  -- gitsigns
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  -- autocompletion
  { src = 'https://github.com/saghen/blink.cmp' },
  -- debugger
  { src = 'https://github.com/mfussenegger/nvim-dap' },
  -- displays the actions that are possible from further key presses
  { src = 'https://github.com/folke/which-key.nvim' },
  -- live markdown previewer
  { src = 'https://github.com/brianhuster/live-preview.nvim' },
  -- file picker and its dependency
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  -- netrw replacement (another file explorer)
  { src = 'https://github.com/stevearc/oil.nvim' },
  -- terminal agentic ai integration
  { src = 'https://github.com/NickvanDyke/opencode.nvim' },
  { src = 'https://github.com/folke/snacks.nvim' },
  -- scope/indentation lines
  { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
  -- simplifies the editing of surrounding tags (", ', [, {, <div>, etc)
  { src = 'https://github.com/tpope/vim-surround' },
}


-- plugin configurations
require('blink.cmp').setup({
  fuzzy = {
    implementation = 'prefer_rust',
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    ghost_text = { enabled = true },
    menu = {
      auto_show = true,
      draw = {
        treesitter = { 'lsp' },
        columns = { { 'kind_icon', 'label', 'label_description', gap = 1 }, { 'kind' } }
      }
    }
  },
  signature = { enabled = true }
})
-- require('gruvbox').setup({ contrast = 'hard' })
-- vim.cmd('colorscheme gruvbox')
require('everforest').setup()
vim.cmd('colorscheme everforest')
require('gitsigns').setup({
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    local function nav_hunk(key, direction)
      map('n', key, function()
        if vim.wo.diff then
          vim.cmd.normal({ key, bang = true })
        else
          gitsigns.nav_hunk(direction)
        end
      end)
    end
    nav_hunk(']c', 'next')
    nav_hunk('[c', 'prev')
    
    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hr', gitsigns.reset_hunk)
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hd', gitsigns.diffthis)
    map('n', '<leader>hq', gitsigns.setqflist)

    -- Text object
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
  end
})
require('which-key').setup({ preset = 'helix' })
require('oil').setup()
-- require('opencode').setup()
require('ibl').setup()


-- [[ keymaps ]]
-- plugin mappings
vim.keymap.set('n', '<leader>b', ':!bun run build<CR><CR>', { desc = 'bun run build' })
vim.keymap.set('n', '<leader>o', ':Oil<CR>', { desc = 'open oil in the pwd' })
vim.keymap.set('n', '<leader>sf', ':Telescope find_files<CR>', { desc = 'search files in pwd' })
vim.keymap.set('n', '<leader>g', ':Telescope live_grep<CR>', { desc = 'ripgrep in pwd' })
vim.keymap.set('n', '<leader>sh', ':Telescope help_tags<CR>', { desc = 'search help' })
vim.keymap.set('n', '<leader>to', function() require('opencode').toggle() end, { desc = 'toggle opencode embedding' })
vim.keymap.set('n', '<leader>ao', function() require('opencode').ask() end, { desc = 'ask opencode' })
vim.keymap.set('v', '<leader>ao', function() require('opencode').ask('@selection: ') end, { desc = 'ask opencode about selection' })
vim.keymap.set('n', '<leader>po', function() require('opencode').select_prompt() end, { desc = 'select opencode prompt' })

-- diagnostic and lsp mappings
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'open diagnostic quickfix list' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'open diagnostic' })
vim.keymap.set('n', '<leader>vs', vim.lsp.buf.signature_help, { desc = 'view signature' })
vim.keymap.set('n', '<leader>vd', vim.lsp.buf.hover, { desc = 'view details' })
vim.keymap.set('n', '<leader>vt', vim.lsp.buf.type_definition, { desc = 'view type' })
vim.keymap.set('n', '<leader>vt', vim.lsp.buf.type_definition, { desc = 'view type' })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'format buffer' })

-- centered screen scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'scroll half page down and center' })
vim.keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'scroll full page down and center' })
vim.keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'scroll full page up and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'scroll half page up and center' })

-- better start/end of line navigation
vim.keymap.set('n', 'gs', '^', { desc = 'goto start of line' })
vim.keymap.set('v', 'gs', '^', { desc = 'goto start of line' })
vim.keymap.set('n', 'ge', '$', { desc = 'goto end of line' })
vim.keymap.set('v', 'ge', '$', { desc = 'goto end of line' })

-- ensure ctrl-[ does everything that esc does
vim.keymap.set('n', '<C-[>', '<cmd>nohlsearch<CR>', { desc = 'clear search highlight' })

-- diable arrow keys in normal mode
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', { silent = true, noremap = true })

-- highlight copied text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function() vim.hl.on_yank() end,
})

-- [[ language server provider (lsp) setup ]]
-- (to add more, download the lsp, add it here, and configure it
-- like the other language servers in ./lsp/, with :help lspconfig-all)
vim.lsp.enable({
  'clangd',
  'lua_ls',
  'ts_ls',
  'pyright',
  'html',
  'cssls',
  'rust_analyzer',
})
