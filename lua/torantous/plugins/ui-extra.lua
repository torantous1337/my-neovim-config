-- ============================================================================
--  ███████╗██╗  ██╗████████╗██████╗  █████╗     ██████╗ ██████╗ ██╗██████╗
--  ██╔════╝╚██╗██╔╝╚══██╔══╝██╔══██╗██╔══██╗    ██╔══██╗██╔══██╗██║██╔══██╗
--  █████╗   ╚███╔╝    ██║   ██████╔╝███████║    ██║  ██║██████╔╝██║██████╔╝
--  ██╔══╝   ██╔██╗    ██║   ██╔══██╗██╔══██║    ██║  ██║██╔══██╗██║██╔═══╝
--  ███████╗██╔╝ ██╗   ██║   ██║  ██║██║  ██║    ██████╔╝██║  ██║██║██║
--  ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝
--  EXTRA UI DRIP // MAXIMUM AESTHETIC
-- ============================================================================

return {
  -- ══════════════════════════════════════════════════════════════════════
  -- DROPBAR (VS Code-like breadcrumbs at top)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("dropbar").setup({
        icons = {
          enable = true,
          kinds = {
            symbols = {
              Array = "󰅪 ",
              Boolean = " ",
              BreakStatement = "󰙧 ",
              Call = "󰃷 ",
              CaseStatement = "󱃙 ",
              Class = " ",
              Color = "󰏘 ",
              Constant = "󰏿 ",
              Constructor = " ",
              ContinueStatement = "→ ",
              Copilot = " ",
              Declaration = "󰙠 ",
              Delete = "󰩺 ",
              DoStatement = "󰑖 ",
              Enum = " ",
              EnumMember = " ",
              Event = " ",
              Field = " ",
              File = "󰈔 ",
              Folder = " ",
              ForStatement = "󰑖 ",
              Function = "󰊕 ",
              Identifier = "󰀫 ",
              IfStatement = "󰇉 ",
              Interface = " ",
              Keyword = " ",
              List = "󰅪 ",
              Log = "󰦪 ",
              Lsp = " ",
              Macro = "󰁌 ",
              MarkdownH1 = "󰉫 ",
              MarkdownH2 = "󰉬 ",
              MarkdownH3 = "󰉭 ",
              MarkdownH4 = "󰉮 ",
              MarkdownH5 = "󰉯 ",
              MarkdownH6 = "󰉰 ",
              Method = "󰆧 ",
              Module = "󰏗 ",
              Namespace = " ",
              Null = "󰟢 ",
              Number = "󰎠 ",
              Object = " ",
              Operator = "󰆕 ",
              Package = "󰏗 ",
              Property = " ",
              Reference = " ",
              Regex = " ",
              Repeat = "󰑖 ",
              Scope = " ",
              Snippet = " ",
              Specifier = "󰦪 ",
              Statement = " ",
              String = " ",
              Struct = " ",
              SwitchStatement = "󰺟 ",
              Terminal = " ",
              Text = " ",
              Type = " ",
              TypeParameter = "󰆩 ",
              Unit = " ",
              Value = "󰎠 ",
              Variable = "󰀫 ",
              WhileStatement = "󰑖 ",
            },
          },
          ui = {
            bar = {
              separator = "  ",
              extends = "…",
            },
            menu = {
              separator = " ",
              indicator = " ",
            },
          },
        },
        bar = {
          hover = true,
          sources = function(buf, _)
            local sources = require("dropbar.sources")
            local utils = require("dropbar.utils")
            if vim.bo[buf].ft == "markdown" then
              return { sources.markdown }
            end
            if vim.bo[buf].buftype == "terminal" then
              return { sources.terminal }
            end
            return { sources.path, utils.source.fallback({ sources.lsp, sources.treesitter }) }
          end,
          padding = { left = 1, right = 1 },
        },
      })

      -- Highlights
      vim.api.nvim_set_hl(0, "DropBarIconKindFunction", { fg = mocha.mauve })
      vim.api.nvim_set_hl(0, "DropBarIconKindMethod", { fg = mocha.mauve })
      vim.api.nvim_set_hl(0, "DropBarIconKindClass", { fg = mocha.yellow })
      vim.api.nvim_set_hl(0, "DropBarIconKindStruct", { fg = mocha.yellow })
      vim.api.nvim_set_hl(0, "DropBarIconKindModule", { fg = mocha.blue })
      vim.api.nvim_set_hl(0, "DropBarIconKindFile", { fg = mocha.text })
      vim.api.nvim_set_hl(0, "DropBarIconKindFolder", { fg = mocha.peach })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- HLCHUNK (better code context lines)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "shellRaining/hlchunk.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("hlchunk").setup({
        chunk = {
          enable = true,
          style = {
            { fg = mocha.mauve },
            { fg = mocha.red },
          },
          use_treesitter = true,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
          textobject = "",
          max_file_size = 1024 * 1024,
          error_sign = true,
          animation_easing = "expo",
          duration = 200,
        },
        indent = {
          enable = true,
          style = { { fg = mocha.surface0 } },
          use_treesitter = false,
          chars = { "│" },
        },
        line_num = {
          enable = true,
          style = mocha.mauve,
          use_treesitter = true,
        },
        blank = { enable = false },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- MODES. NVIM (change line color based on mode)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("modes").setup({
        colors = {
          bg = "",
          copy = mocha.yellow,
          delete = mocha.red,
          insert = mocha.green,
          visual = mocha.mauve,
        },
        line_opacity = 0.25,
        set_cursor = true,
        set_cursorline = true,
        set_number = true,
        ignore_filetypes = { "NvimTree", "TelescopePrompt", "alpha", "neo-tree" },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- REACTIVE.NVIM (reactive cursor line based on mode)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "rasulomaroff/reactive.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("reactive").setup({
        builtin = {
          cursorline = true,
          cursor = true,
          modemsg = true,
        },
        load = { "catppuccin-mocha-cursor", "catppuccin-mocha-cursorline" },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- NVIM-SCROLLBAR (scrollbar with diagnostics & search)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("scrollbar").setup({
        show = true,
        show_in_active_only = false,
        set_highlights = true,
        folds = 1000,
        max_lines = false,
        hide_if_all_visible = true,
        throttle_ms = 100,
        handle = {
          text = " ",
          blend = 30,
          color = mocha.surface1,
          color_nr = nil,
          highlight = "ScrollbarHandle",
          hide_if_all_visible = true,
        },
        marks = {
          Cursor = { text = "•", priority = 0, gui = nil, color = mocha.mauve, cterm = nil, color_nr = nil, highlight = "ScrollbarCursor" },
          Search = { text = { "-", "=" }, priority = 1, gui = nil, color = mocha.peach, cterm = nil, color_nr = nil, highlight = "ScrollbarSearch" },
          Error = { text = { "-", "=" }, priority = 2, gui = nil, color = mocha.red, cterm = nil, color_nr = nil, highlight = "ScrollbarError" },
          Warn = { text = { "-", "=" }, priority = 3, gui = nil, color = mocha.yellow, cterm = nil, color_nr = nil, highlight = "ScrollbarWarn" },
          Info = { text = { "-", "=" }, priority = 4, gui = nil, color = mocha.sky, cterm = nil, color_nr = nil, highlight = "ScrollbarInfo" },
          Hint = { text = { "-", "=" }, priority = 5, gui = nil, color = mocha.teal, cterm = nil, color_nr = nil, highlight = "ScrollbarHint" },
          Misc = { text = { "-", "=" }, priority = 6, gui = nil, color = mocha.mauve, cterm = nil, color_nr = nil, highlight = "ScrollbarMisc" },
          GitAdd = { text = "│", priority = 7, gui = nil, color = mocha.green, cterm = nil, color_nr = nil, highlight = "ScrollbarGitAdd" },
          GitChange = { text = "│", priority = 7, gui = nil, color = mocha.peach, cterm = nil, color_nr = nil, highlight = "ScrollbarGitChange" },
          GitDelete = { text = "▁", priority = 7, gui = nil, color = mocha.red, cterm = nil, color_nr = nil, highlight = "ScrollbarGitDelete" },
        },
        excluded_buftypes = { "terminal" },
        excluded_filetypes = { "alpha", "NvimTree", "lazy", "mason", "TelescopePrompt" },
        autocmd = { render = { "BufWinEnter", "TabEnter", "TermEnter", "WinEnter", "CmdwinLeave", "TextChanged", "VimResized", "WinScrolled" }, clear = { "BufWinLeave", "TabLeave", "TermLeave", "WinLeave" } },
        handlers = { cursor = true, diagnostic = true, gitsigns = true, handle = true, search = false, ale = false },
      })

      -- Gitsigns integration
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- WINDOW-PICKER (pick window with letters)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "s1n7ax/nvim-window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("window-picker").setup({
        hint = "floating-big-letter",
        selection_chars = "FJDKSLA;CMRUEIWOQP",
        picker_config = {
          statusline_winbar_picker = {
            selection_display = function(char, _)
              return "%=" .. char .. "%="
            end,
            use_winbar = "smart",
          },
          floating_big_letter = {
            font = "ansi-shadow",
          },
        },
        show_prompt = false,
        filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        bo = {
        filetype = { "NvimTree", "neo-tree", "notify", "noice", "alpha" },
        buftype = { "terminal", "quickfix" },
      },
    },
    highlights = {
    statusline = { focused = { fg = mocha.base, bg = mocha.mauve, bold = true }, unfocused = { fg = mocha.base, bg = mocha.surface1 } },
    winbar = { focused = { fg = mocha.base, bg = mocha.mauve, bold = true }, unfocused = { fg = mocha.base, bg = mocha.surface1 } },
  },
})
    end,
  },
  -- ══════════════════════════════════════════════════════════════════════
  -- SATELLITE (mini-map in scrollbar area)
  -- ══════════════════════════════════════════════════════════════════════
  -- {
  --   "lewis6991/satellite.nvim",
  --   event = "VeryLazy",
  --   config = function()
    --     require("satellite").setup({
    --       current_only = false,
    --       winblend = 50,
    --       zindex = 40,
    --       excluded_filetypes = { "alpha", "NvimTree", "TelescopePrompt" },
    --       width = 2,
    --       handlers = {
    --         cursor = { enable = true, symbols = { "⎺", "⎻", "⎼", "⎽" } },
    --         search = { enable = true },
    --         diagnostic = { enable = true, signs = { "-", "=", "≡" }, min_severity = vim.diagnostic.severity.HINT },
    --         gitsigns = { enable = true, signs = { add = "│", change = "│", delete = "-" } },
    --         marks = { enable = true, show_builtins = false, key = "m" },
    --       },
    --     })
    --   end,
    -- },
    
    -- ══════════════════════════════════════════════════════════════════════
    -- HEADLINES (markdown header highlights)
    -- ══════════════════════════════════════════════════════════════════════
    {
    "lukas-reineke/headlines.nvim",
    ft = { "markdown", "norg", "org", "rmd" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      vim.api.nvim_set_hl(0, "Headline1", { fg = mocha.red, bg = mocha.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline2", { fg = mocha.peach, bg = mocha.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline3", { fg = mocha.yellow, bg = mocha.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline4", { fg = mocha.green, bg = mocha.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline5", { fg = mocha.blue, bg = mocha.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline6", { fg = mocha.mauve, bg = mocha.surface0, bold = true })
      vim.api.nvim_set_hl(0, "CodeBlock", { bg = mocha.mantle })
      vim.api.nvim_set_hl(0, "Dash", { fg = mocha.overlay0, bold = true })
      vim.api.nvim_set_hl(0, "Quote", { fg = mocha.subtext1, italic = true })
      require("headlines").setup({
      markdown = {
      query = vim.treesitter.query.parse("markdown", [[
      (atx_heading [
      (atx_h1_marker)
      (atx_h2_marker)
      (atx_h3_marker)
      (atx_h4_marker)
      (atx_h5_marker)
      (atx_h6_marker)
      ] @headline)
      (thematic_break) @dash
      (fenced_code_block) @codeblock
      (block_quote) @quote
      ]]),
      headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
      bullet_highlights = { "@text.title.1.marker.markdown", "@text.title.2.marker.markdown", "@text.title.3.marker.markdown", "@text.title.4.marker.markdown", "@text.title.5.marker.markdown", "@text.title.6.marker.markdown" },
      bullets = { "◉", "○", "✸", "✿" },
      codeblock_highlight = "CodeBlock",
      dash_highlight = "Dash",
      dash_string = "─",
      quote_highlight = "Quote",
      quote_string = "┃",
      fat_headlines = true,
      fat_headline_upper_string = "▄",
      fat_headline_lower_string = "▀",
    },
  })
end,
  },
  
  -- ══════════════════════════════════════════════════════════════════════
  -- DRESSING (better vim.ui.input and vim.ui.select)
  -- ══════════════════════════════════════════════════════════════════════
  {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function()
    require("dressing").setup({
    input = {
    enabled = true,
    default_prompt = "➤ ",
    trim_prompt = true,
    title_pos = "center",
    insert_only = true,
    start_in_insert = true,
    border = "rounded",
    relative = "cursor",
    prefer_width = 40,
    width = nil,
    max_width = { 140, 0.9 },
    min_width = { 20, 0.2 },
    buf_options = {},
    win_options = {
    wrap = false,
    list = true,
    listchars = "precedes:…,extends:…",
    sidescrolloff = 0,
  },
  mappings = {
  n = { ["<Esc>"] = "Close", ["<CR>"] = "Confirm" },
  i = { ["<C-c>"] = "Close", ["<CR>"] = "Confirm", ["<Up>"] = "HistoryPrev", ["<Down>"] = "HistoryNext" },
},
        },
        select = {
        enabled = true,
        backend = { "telescope", "builtin", "nui" },
        trim_prompt = true,
        telescope = nil,
        builtin = {
        show_numbers = true,
        border = "rounded",
        relative = "editor",
        buf_options = {},
        win_options = { cursorline = true, cursorlineopt = "both" },
        width = nil,
        max_width = { 140, 0.8 },
        min_width = { 40, 0.2 },
        height = nil,
        max_height = 0.9,
        min_height = { 10, 0.2 },
        mappings = { ["<Esc>"] = "Close", ["<C-c>"] = "Close", ["<CR>"] = "Confirm" },
      },
    },
  })
end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- FIDGET (LSP progress spinner)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("fidget").setup({
        progress = {
          poll_rate = 0,
          suppress_on_insert = true,
          ignore_done_already = false,
          ignore_empty_message = false,
          notification_group = function(msg)
            return msg.lsp_client.name
          end,
          clear_on_detach = function(client_id)
            local client = vim.lsp.get_client_by_id(client_id)
            return client and client.name or nil
          end,
          ignore = {},
          display = {
            render_limit = 16,
            done_ttl = 3,
            done_icon = "✓",
            done_style = "Constant",
            progress_ttl = math.huge,
            progress_icon = { pattern = "dots", period = 1 },
            progress_style = "WarningMsg",
            group_style = "Title",
            icon_style = "Question",
            priority = 30,
            skip_history = true,
            format_message = require("fidget.progress.display").default_format_message,
            format_annote = function(msg)
              return msg.title
            end,
            format_group_name = function(group)
              return tostring(group)
            end,
            overrides = { rust_analyzer = { name = "rust-analyzer" } },
          },
          lsp = {
            progress_ringbuf_size = 0,
            log_handler = false,
          },
        },
        notification = {
          poll_rate = 10,
          filter = vim.log.levels.INFO,
          history_size = 128,
          override_vim_notify = false,
          configs = { default = require("fidget.notification").default_config },
          redirect = function(msg, level, opts)
            if opts and opts.on_open then
              return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
            end
          end,
          view = {
            stack_upwards = true,
            icon_separator = " ",
            group_separator = "---",
            group_separator_hl = "Comment",
            render_message = function(msg, cnt)
              return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
            end,
          },
          window = {
            normal_hl = "Comment",
            winblend = 0,
            border = "none",
            zindex = 45,
            max_width = 0,
            max_height = 0,
            x_padding = 1,
            y_padding = 0,
            align = "bottom",
            relative = "editor",
          },
        },
        integration = {
          ["nvim-tree"] = { enable = true },
          ["xcodebuild-nvim"] = { enable = true },
        },
        logger = {
          level = vim.log.levels.WARN,
          max_size = 10000,
          float_precision = 0.01,
          path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
        },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- ILLUMINATE (highlight same words)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("illuminate").configure({
        providers = { "lsp", "treesitter", "regex" },
        delay = 100,
        filetypes_denylist = { "alpha", "NvimTree", "TelescopePrompt", "lazy", "mason" },
        under_cursor = true,
        large_file_cutoff = nil,
        large_file_overrides = nil,
        min_count_to_highlight = 1,
        should_enable = function(_)
          return true
        end,
        case_insensitive_regex = false,
      })

      vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = mocha.surface1 })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = mocha.surface1 })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = mocha.surface1 })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- SMEAR-CURSOR (cursor smear effect)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      use_floating_windows = true,
      legacy_computing_symbols_support = false,
      hide_target_hack = true,
      cursor_color = "#cba6f7",  -- mauve
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
      trailing_exponent = 0,
    },
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- MINI. CURSORWORD (underline word under cursor)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    config = function()
      require("mini.cursorword").setup({ delay = 100 })

      local mocha = require("catppuccin.palettes").get_palette("mocha")
      vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true, sp = mocha.mauve })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = true, sp = mocha.mauve })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- VIRT-COLUMN (colored column line)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "lukas-reineke/virt-column.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("virt-column").setup({
        char = "│",
        virtcolumn = "80,120",
        highlight = "VirtColumn",
      })

      vim.api.nvim_set_hl(0, "VirtColumn", { fg = mocha.surface0 })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- RAINBOW DELIMITERS (rainbow brackets)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = mocha.red })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = mocha.yellow })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = mocha.blue })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = mocha.peach })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = mocha.green })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = mocha.mauve })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = mocha.teal })

      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- GITSIGNS (git decorations) - ENHANCED
  -- ══════════════════════════════════════════════════════════════════════
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        signs_staged = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
        },
        signcolumn = true,
        numhl = true,
        linehl = false,
        word_diff = false,
        watch_gitdir = { follow_files = true },
        auto_attach = true,
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 500,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = "   <author>, <author_time:%R> • <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          -- Navigation
          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
          map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
          map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Hunk")
          map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset Hunk")
          map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
          map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle Blame")
          map("n", "<leader>hd", gs.diffthis, "Diff This")
          map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
          map("n", "<leader>td", gs.toggle_deleted, "Toggle Deleted")
        end,
      })
    end,
  },
  -- ══════════════════════════════════════════════════════════════════════
  -- TROUBLE (beautiful diagnostics panel)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle" },
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("trouble").setup({
        position = "bottom",
        height = 12,
        icons = true,
        mode = "workspace_diagnostics",
        fold_open = "",
        fold_closed = "",
        group = true,
        padding = true,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          close_folds = { "zM", "zm" },
          open_folds = { "zR", "zr" },
          toggle_fold = { "zA", "za" },
          previous = "k",
          next = "j",
        },
        indent_lines = true,
        auto_open = false,
        auto_close = true,
        auto_preview = true,
        auto_fold = false,
        signs = {
          error = "",
          warning = "",
          hint = "󰌵",
          information = "",
          other = "",
        },
        use_diagnostic_signs = false,
      })
    end,
    keys = {
      { "<leader>xT", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble:  Diagnostics" },
      { "<leader>xt", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Trouble: Symbols" },
      { "<leader>xr", "<cmd>Trouble lsp toggle focus=false<cr>", desc = "Trouble: LSP references" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble: Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble: Quickfix" },
    },
  },
}
