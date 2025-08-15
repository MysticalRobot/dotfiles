-- [[ options ]]
vim.g.mapleader = ' '                -- specify the key used as <leader>
vim.g.have_nerd_font = true          -- use nerd font
vim.o.spelllang = 'en'               -- enable spell checking for english
vim.o.winborder = 'rounded'          -- rounded border to floating windows
vim.o.number = true                  -- show line numbers
vim.o.relativenumber = true          -- make line numbers relative
vim.o.wrap = false                   -- diable line wrapping
vim.o.mouse = 'a'                    -- enable mouse mode
vim.o.clipboard = 'unnamedplus'      -- sync OS and nvim clipboards
vim.o.undofile = true                -- save undo history
vim.o.ignorecase = true              -- case-insenstive searching
vim.o.smartcase = true               -- case-sensitive searching if /C or >= 1 capital letters are used
vim.o.signcolumn = 'yes'             -- show sign column
vim.o.inccommand = 'split'           -- preview substitutions while typing
vim.o.cursorline = true              -- show the line your cursor is on
vim.o.scrolloff = 10                 -- minimum number of screen lines aboes and below the cursor
vim.o.expandtab = true               -- use spaces for indentation
vim.o.shiftwidth = 2                 -- use 2 spaces for indentation
vim.o.tabstop = 2                    -- insert 2 spaces by hitting tab
vim.o.confirm = true                 -- raise a dialog to confirm the handling of unsaved changes
vim.g.loaded_netrwPlugin = 1         -- disable netrw since yazi is begin used
vim.cmd(':hi statusline guibg=NONE') -- remove the background the status line

-- [[ plugins ]]
vim.pack.add({
  -- directory of language server quickstart configurations
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  -- autocompletion
  { src = 'https://github.com/saghen/blink.cmp' },
  -- theme
  { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
  -- debugger
  { src = 'https://github.com/mfussenegger/nvim-dap' },
  -- displays the actions that are possible from further key presses
  { src = 'https://github.com/folke/which-key.nvim' },
  -- live markdown previewer
  { src = 'https://github.com/brianhuster/live-preview.nvim' },
  -- handle surrounding text better (brackets, quotes, etc.)
  -- sa = add surrounding, sd = delete surrounding,
  -- sh = highlight surrounding, sr = replace surrounding,
  -- sf = find right surrounding, sF = find left surrounding
  { src = 'https://github.com/echasnovski/mini.surround' },
  -- file picker
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  -- goated terminal file explorer along with its dependencies
  { src = 'https://github.com/mikavilpas/yazi.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/folke/snacks.nvim' },
})
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
require('gruvbox').setup({ contrast = 'hard' })
vim.cmd('colorscheme gruvbox')
require('which-key').setup({ preset = 'helix' })
require('mini.surround').setup()
require('yazi').setup()

-- [[ keymaps ]]
-- plugin mappings
vim.keymap.set('n', '<leader>y', ':Yazi<CR>', { desc = 'open yazi in the pwd' })
vim.keymap.set('n', '<leader>s', ':Telescope find_files<CR>', { desc = 'search files in pwd' })
vim.keymap.set('n', '<leader>g', ':Telescope live_grep<CR>', { desc = 'ripgrep in pwd' })
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>', { desc = 'search recent buffers' })
vim.keymap.set('n', '<leader>h', ':Telescope help_tags<CR>', { desc = 'search help' })
-- disable s so that mini.surround can use s
vim.api.nvim_set_keymap('n', 's', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 's', '<Nop>', { noremap = true, silent = true })
-- lsp mappings
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'open diagnostic quickfix list' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'open diagnostic' })
vim.keymap.set('n', '<leader>i', vim.lsp.buf.signature_help, { desc = 'inspect signature' })
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
  callback = function()
    vim.hl.on_yank()
  end,
})
-- format buffer (file) on write
vim.api.nvim_create_autocmd('BufWrite', {
  desc = 'format buffer on write',
  callback = function()
    vim.lsp.buf.format()
  end
})
-- intuitive navigation between panes of both tmux and nvim
local function smart_move(direction, tmux_cmd)
  local curwin = vim.api.nvim_get_current_win()
  vim.cmd('wincmd ' .. direction)
  if curwin == vim.api.nvim_get_current_win() then
    vim.fn.system('tmux select-pane ' .. tmux_cmd)
  end
end
vim.keymap.set('n', '<C-h>', function() smart_move('h', '-L') end, { silent = true })
vim.keymap.set('n', '<C-j>', function() smart_move('j', '-D') end, { silent = true })
vim.keymap.set('n', '<C-k>', function() smart_move('k', '-U') end, { silent = true })
vim.keymap.set('n', '<C-l>', function() smart_move('l', '-R') end, { silent = true })

-- [[ language server provider (lsp) setup ]]
-- (to add more, download the lsp, add it here, and configure it
-- like the other language servers in ./lsp/, with :help lspconfig-all)
vim.lsp.enable({ 'clangd', 'lua_ls', 'ts_ls', 'pyright', 'racket_langserver' })
