-- ============================================================================
--  ██████╗ ██╗     ██╗███╗   ██╗ ██████╗     ██╗   ██╗██╗
--  ██╔══██╗██║     ██║████╗  ██║██╔════╝     ██║   ██║██║
--  ██████╔╝██║     ██║██╔██╗ ██║██║  ███╗    ██║   ██║██║
--  ██╔══██╗██║     ██║██║╚██╗██║██║   ██║    ██║   ██║██║
--  ██████╔╝███████╗██║██║ ╚████║╚██████╔╝    ╚██████╔╝██║
--  ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝      ╚═════╝ ╚═╝
--  EXTRA BLING PLUGINS // MAKE IT LOOK INSANELY SICK
-- ============================================================================

return {
  -- ══════════════════════════════════════════════════════════════════════
  -- INCLINE (floating filenames at top of each window)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      local devicons = require("nvim-web-devicons")
      
      require("incline").setup({
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          
          local function get_diagnostic_label()
            local icons = { error = " ", warn = " ", info = " ", hint = "󰌵 " }
            local label = {}
            
            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. string.upper(severity):sub(1, 1) .. string.lower(severity):sub(2) })
              end
            end
            return label
          end
          
          local function get_git_diff()
            local icons = { removed = " ", changed = "󰝤 ", added = " " }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if not signs then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
              end
            end
            return labels
          end
          
          local buffer = {
            { get_diagnostic_label() },
            { get_git_diff() },
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
            { filename .. " ", gui = modified and "bold,italic" or "bold" },
            { modified and "󰏫 " or "" },
          }
          
          return buffer
        end,
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
          placement = { horizontal = "right", vertical = "top" },
          winhighlight = {
            active = {
              Normal = { guibg = mocha.surface0 },
            },
            inactive = {
              Normal = { guibg = mocha.mantle },
            },
          },
        },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- CODEWINDOW (VSCode-style minimap)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "gorbit99/codewindow.nvim",
    event = "VeryLazy",
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup({
        auto_enable = false,
        minimap_width = 15,
        width_multiplier = 4,
        use_treesitter = true,
        use_git = true,
        z_index = 1,
        screen_bounds = "lines",
        window_border = "rounded",
      })
      
      -- Add keymap for toggling minimap
      vim.keymap.set("n", "<leader>um", codewindow.toggle_minimap, { desc = "Toggle minimap" })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- WILDER (beautiful command line autocomplete)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    dependencies = { "romgrk/fzy-lua-native" },
    config = function()
      local wilder = require("wilder")
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      
      wilder.setup({ modes = { ":", "/", "?" } })
      
      -- Fuzzy finder
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),
          wilder.vim_search_pipeline()
        ),
      })
      
      -- Popup menu with rounded borders
      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
          highlighter = wilder.lua_fzy_highlighter(),
          highlights = {
            border = "Normal",
            accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = mocha.mauve } }),
          },
          border = "rounded",
          max_height = 15,
          min_height = 0,
          prompt_position = "top",
          reverse = 0,
          left = { " ", wilder.popupmenu_devicons() },
          right = { " ", wilder.popupmenu_scrollbar() },
        }))
      )
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- BLOCK.NVIM (animated scope indicator)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "HampusHauffman/block.nvim",
    event = "VeryLazy",
    config = function()
      require("block").setup({
        percent = 0.8,
        depth = 4,
        colors = nil, -- Uses theme colors
        automatic = false,
      })
      
      -- Add keymap for toggling block highlighting
      vim.keymap.set("n", "<leader>ub", "<cmd>Block<cr>", { desc = "Toggle block highlighting" })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- CHEATSHEET (searchable keybind reference)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "sudormrfbin/cheatsheet.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Cheatsheet",
    config = function()
      require("cheatsheet").setup({
        bundled_cheatsheets = true,
        bundled_plugin_cheatsheets = true,
        include_only_installed_plugins = true,
        telescope_mappings = {
          ["<CR>"] = require("cheatsheet.telescope.actions").select_or_fill_commandline,
          ["<A-CR>"] = require("cheatsheet.telescope.actions").select_or_execute,
          ["<C-Y>"] = require("cheatsheet.telescope.actions").copy_cheat_value,
          ["<C-E>"] = require("cheatsheet.telescope.actions").edit_user_cheatsheet,
        },
      })
      
      -- Add keymap for opening cheatsheet
      vim.keymap.set("n", "<leader>?", "<cmd>Cheatsheet<cr>", { desc = "Keybind cheatsheet" })
    end,
  },
}
