return {
  -- disable default plugins
  { "echasnovski/mini.ai",                 enabled = false },
  { "echasnovski/mini.pairs",              enabled = false },
  { "echasnovski/mini.surround",           enabled = false },
  { "echasnovski/mini.indentscope",        enabled = false },
  { "nvimdev/dashboard-nvim",              enabled = false },
  { "goolord/alpha-nvim",                  enabled = false },
  { "catppuccin/nvim",                     enabled = false },
  { "lewis6991/gitsigns.nvim",             enabled = false },
  { "folke/flash.nvim",                    enabled = false },
  { "folke/todo-comments.nvim",            enabled = false },
  { "folke/persistence.nvim",              enabled = false },

  -- custom plugins
  { "airblade/vim-gitgutter"        },
  { "machakann/vim-highlightedyank" },
  { "tpope/vim-fugitive"            },
  { "junegunn/gv.vim"               },

  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" }, -- moon vs night vs ...
  },

  -- configure neo-tree 
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", "<leader>fE", desc="Explorer NeoTree (cwd)",  remap=true },
      { "<leader>E", "<leader>fe", desc="Explorer NeoTree (root)", remap=true },
      { "<C-n>",     "<leader>fE", desc="Explorer NeoTree (root)", remap=true }
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            -- '.git',
            -- '.DS_Store',
            -- 'thumbs.db',
          },
          never_show = {},
        },
      }
    }
  },

  -- auto complete
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end,
  },
}
