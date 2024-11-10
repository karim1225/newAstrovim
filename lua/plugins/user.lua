---@type lazyspec
return {
  -- تنظیمات LSP
  {
    "neovim/nvim-lspconfig",
    config = function()

      local lspconfig = require "lspconfig"

      -- پیکربندی TypeScript و Vue
      lspconfig.ts_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "/Users/cyber98/.nvm/versions/node/v20.17.0/lib/node_modules/@vue/typescript-plugin",
              languages = { "vue" },
            },
          },
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      }

      -- پیکربندی Volar برای Vue
      -- lspconfig.volar.setup {}

      -- پیکربندی سرورهای HTML، CSS، ESLint
      local servers = { "html", "cssls", "eslint" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      -- پیکربندی Clangd برای C/C++
      lspconfig.clangd.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
  },

  -- سایر پلاگین‌ها
  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "bufread",
    config = function()
      require("lsp_signature").setup()
    end,
  },

  -- پلاگین‌های سفارشی
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  {
      "VonHeikemen/fine-cmdline.nvim",
      requires = {
        { "MunifTanjim/nui.nvim" },
      },
  },
  {
      "folke/noice.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      opts = {},
      event = "VeryLazy",
      config = function()
        require("noice").setup {
          lsp = {
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true,
            },
            hover = { enabled = false }, -- <-- HERE!
            signature = { enabled = false }, -- <-- HERE!
          },
          presets = {
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = false, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
          },
        }
        require("noice.lsp").hover()
      end,
    },
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {},
      event = "User AstroFile",
      cmd = { "TodoQuickFix" },
      keys = {
        { "<leader>T", "<cmd>TodoTelescope<cr>", desc = "Open TODOSs in Telescope" },
      },
    },
  
}
