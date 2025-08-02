vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.showmode = false

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"

vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.undofile = true

vim.opt.updatetime = 250
--vim.opt.timeoutlen = 600

vim.opt.inccommand = "split"

-- [[ Autocommands ]]

-- save and load folds automatically
vim.api.nvim_create_autocmd({"BufWinLeave"}, {pattern = "*.*", command = "mkview"})
vim.api.nvim_create_autocmd({"BufWinEnter"}, {pattern = "*.*", command = "silent! loadview"})

-- [[ Keymaps ]]

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")

vim.keymap.set("n", "<leader>b", ":Neotree toggle show buffers right<cr>")

vim.keymap.set("n", "<leader>gs", ":Neogit<cr>")

-- copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+yy')
-- paste from clipboard
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>p", '"+p')

-- [[ Plugins ]]

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
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

require("lazy").setup({
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

  require("plugins.lualine"), -- status bar
  --require("plugins.bufferline"), -- "tabs" bar
  require("plugins.neo-tree"), -- file browser
  require("plugins.telescope"), -- telescope
  require("plugins.treesitter"),
  require("plugins.cmp"),
  require("plugins.which-key"),
  require("plugins.gitsigns"),

  "lepture/vim-jinja",

  {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
    },
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  -- TODO: toggleterm.nvim

  -- [[ LSP ]]

  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  require("plugins.lspconfig"),

  { -- Autoformat
    "stevearc/conform.nvim", -- TODO: figure this plugin out
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      --format_on_save = function(bufnr)
      --  -- Disable "format_on_save lsp_fallback" for languages that don't
      --  -- have a well standardized coding style. You can add additional
      --  -- languages here or re-enable it for the disabled ones.
      --  local disable_filetypes = { c = true, cpp = true }
      --  local lsp_format_opt
      --  if disable_filetypes[vim.bo[bufnr].filetype] then
      --    lsp_format_opt = 'never'
      --  else
      --    lsp_format_opt = 'fallback'
      --  end
      --  return {
      --    timeout_ms = 500,
      --    lsp_format = lsp_format_opt,
      --  }
      --end,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- [[ Themes ]]

  --require('theme')
  --'ayu-theme/ayu-vim',
  {
    "Shatur/neovim-ayu",
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('ayu').setup {
        styles = {
          comments = { italic = true },
        }
      }
      vim.cmd.colorscheme 'ayu'
    end
  },
  "rebelot/kanagawa.nvim",
  "ellisonleao/gruvbox.nvim",
  "Yazeed1s/oh-lucy.nvim",
  "catppuccin/nvim",
  "olimorris/onedarkpro.nvim",
})
