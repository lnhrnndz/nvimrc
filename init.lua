vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = 'yes'

vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.smartindent = true

-- [[ Autocommands ]]

-- save and load folds automatically
vim.api.nvim_create_autocmd({"BufWinLeave"}, {pattern = "*.*", command = "mkview"})
vim.api.nvim_create_autocmd({"BufWinEnter"}, {pattern = "*.*", command = "silent! loadview"})

-- [[ Keymaps ]]

vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')

vim.keymap.set('n', '/', ':Neotree toggle current reveal_force_cwd<cr>')
vim.keymap.set('n', '|', ':Neotree reveal<cr>')
vim.keymap.set('n', 'gd', ':Neotree float reveal_file=<cfile> reveal_force_cwd<cr>')
vim.keymap.set('n', '<leader>b', ':Neotree toggle show buffers right<cr>')
vim.keymap.set('n', '<leader>s', ':Neotree float git_status<cr>')

-- [[ Plugins ]]

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update

require('lazy').setup({
  'tpope/vim-sleuth',                   -- Detect tabstop and shiftwidth automatically

  require('plugins.lualine'),           -- status bar
  require('plugins.bufferline'),        -- "tabs" bar
  require('plugins.neo-tree'),          -- file browser
  require('plugins.telescope'),         -- telescope

  -- [[ Themes ]]
  --require('theme')
  --'ayu-theme/ayu-vim',
  'Shatur/neovim-ayu',
  'rebelot/kanagawa.nvim',
  'ellisonleao/gruvbox.nvim',
  'Yazeed1s/oh-lucy.nvim',
  'catppuccin/nvim',
  'olimorris/onedarkpro.nvim',

})

vim.cmd.colorscheme 'ayu'
