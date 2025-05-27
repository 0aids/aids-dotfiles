# TODO: Split this configuration cause it's a fucking mess!!!
{
  pkgs,
  lib,
  ...
}: {
  config.vim = {
    luaConfigRC.starter = builtins.readFile ./nvim/rc.lua;
    # WARNING: Tinymist is installed globally via pacman. I can't figure out how to pass the setting into the way which nvf wants it to be done, so it has been hardcoded.
    luaConfigPost = ''
      require("lspconfig")["tinymist"].setup({
        settings = {
                formatterMode = "typstyle",
                exportPdf = "onType",
                semanticTokens = "disable",
        },
      })
    ''; # TODO: Maybe make a github issue about not being able to pass settings in to tinymist's setup.

    autocmds = [
    ];
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
      transparent = true;
    };
    diagnostics = {
      enable = true;
      config = {
        virtual_text = true;
      };
    };

    options = {
      autochdir = true;
      smoothscroll = true;
      tabstop = 2;
      smartindent = true;
      shiftwidth = 2;
      expandtab = true;
      number = true;
      relativenumber = true;
      ignorecase = true;
      smartcase = true;
      spell = false;
      undofile = true;
      #  linebreak = true;
      cursorline = true;
      winblend = 0;
      cmdheight = 0;
    };

    globals = {
      mapleader = " ";
      maplocalleader = ",";
    };

    extraPlugins = {
      smart-splits = {
        package = pkgs.vimPlugins.smart-splits-nvim;
        setup = ''
          require('smart-splits').setup({
              default_amount = 6,
          })
        '';
      };
    };

    keymaps = [
      # Keybinds for wrapped words.
      {
        key = "k";
        mode = ["n" "v"];
        expr = true;
        silent = true;
        action = "v:count == 0 ? 'gk': 'k'";
      }
      {
        key = "j";
        mode = ["n" "v"];
        expr = true;
        silent = true;
        action = "v:count == 0 ? 'gj': 'j'";
      }
      {
        mode = ["n"];
        key = "<A-h>";
        lua = true;
        action = "require('smart-splits').resize_left";
      }
      {
        mode = ["n"];
        key = "<A-j>";
        lua = true;
        action = "require('smart-splits').resize_down";
      }
      {
        mode = ["n"];
        key = "<A-k>";
        lua = true;
        action = "require('smart-splits').resize_up";
      }
      {
        mode = ["n"];
        key = "<A-l>";
        lua = true;
        action = "require('smart-splits').resize_right";
      }
      {
        mode = ["n"];
        key = "<C-h>";
        lua = true;
        action = "require('smart-splits').move_cursor_left";
      }
      {
        mode = ["n"];
        key = "<C-j>";
        lua = true;
        action = "require('smart-splits').move_cursor_down";
      }
      {
        mode = ["n"];
        key = "<C-k>";
        lua = true;
        action = "require('smart-splits').move_cursor_up";
      }
      {
        mode = ["n"];
        key = "<C-l>";
        lua = true;
        action = "require('smart-splits').move_cursor_right";
      }
      {
        mode = ["n"];
        key = "<C-\\>";
        lua = true;
        action = "require('smart-splits').move_cursor_previous";
      }
      {
        mode = ["n"];
        key = "<leader><leader>h";
        lua = true;
        action = "require('smart-splits').swap_buf_left";
      }
      {
        mode = ["n"];
        key = "<leader><leader>j";
        lua = true;
        action = "require('smart-splits').swap_buf_down";
      }
      {
        mode = ["n"];
        key = "<leader><leader>k";
        lua = true;
        action = "require('smart-splits').swap_buf_up";
      }
      {
        mode = ["n"];
        key = "<leader><leader>l";
        lua = true;
        action = "require('smart-splits').swap_buf_right";
      }
      {
        mode = ["n"];
        key = "<M-v>";
        action = "<C-w>v";
      }
      {
        mode = ["n"];
        key = "<M-s>";
        action = "<C-w>s";
      }
      {
        mode = ["n"];
        key = "<M-c>";
        action = "<C-w>c";
      }
      {
        mode = ["n"];
        key = "<M-Space>";
        action = "<Plug>(neorg.qol.todo-items.todo.task-cycle)";
      }
      {
        mode = ["t"];
        key = "<C-n>";
        action = "<C-\\><C-n>";
      }
      # {
      #   mode = ["n" "v" "i" "t"];
      #   key = "<M-f>";
      #   lua = true;
      #   action = ''
      #               function()
      #       require("fzf-lua").complete_file({
      #         cmd = "rg --files",
      #         winopts = { preview = { hidden = true } }
      #       })
      #     end, { silent = true, desc = "Fuzzy complete file" }
      #   '';
      # }
      {
        mode = ["n"];
        key = "<leader>ff";
        lua = true;
        action = "function() Snacks.picker.files() end";
        desc = "File picker";
      }
      {
        mode = ["n"];
        key = "<leader>fr";
        lua = true;
        action = "function() Snacks.picker.recent() end";
        desc = "Recent File picker";
      }
      {
        mode = ["n"];
        key = "<leader>fg";
        lua = true;
        action = "function() Snacks.picker.grep() end";
        desc = "Live grep picker";
      }
    ];

    viAlias = true;
    vimAlias = true;
    lsp = {
      enable = true;
      formatOnSave = true;
      trouble.enable = true;
      nvim-docs-view.enable = true;
    };

    notes = {
      neorg = {
        enable = true;
        treesitter.enable = true;
        treesitter.norgPackage = pkgs.tree-sitter-grammars.tree-sitter-norg;
        setupOpts.load = {
          "core.defaults".enable = true;
          "core.concealer".config.icon_preset = "diamond";
          "core.qol.todo_items".config.order = [
            ["undone" " "]
            ["pending" "-"]
            ["done" "x"]
          ];
          "core.dirman".config = {
            workspaces.notes = "~/notes";
            default_workspace = "notes";
          };
          # "core.esupports.metagen".config = {
          #   author = "Aids";
          #   type = "auto";
          #   timezone = "implicit-local";
          #   update_date = true;
          # };
        };
      };
      todo-comments.enable = true;
    };

    visuals = {
    };

    mini = {
      icons.enable = true;
      statusline.enable = false;
      animate = {
        enable = false;
        setupOpts = {
          cursor.enable = false;
          resize.enable = false;
          open.enable = false;
          close.enable = false;
        };
      };
      sessions.enable = true;
    };

    autopairs = {
      nvim-autopairs.enable = true;
    };

    ui.noice.enable = true;

    dashboard.alpha = {
      enable = true;
    };

    binds = {
      whichKey = {
        enable = true;
        setupOpts = {
          preset = "helix";
        };
      };
    };

    utility = {
      yazi-nvim.enable = true;
      yazi-nvim.mappings.openYaziDir = "<leader>y";
      yazi-nvim.mappings.yaziToggle = "<C-CR>";
      yazi-nvim.setupOpts = {
        open_for_directories = true;
        show_hidden = true;
      };
      snacks-nvim.enable = true;
      snacks-nvim.setupOpts = {
        picker.enabled = true;
        picker.win.input.keys = {
        };
      };

      surround = {
        enable = true;
        useVendoredKeybindings = false;
      };
    };

    statusline = {
      lualine.enable = true;
      lualine.activeSection.c = [
        ''
                    {
            function()
              local reg = vim.fn.reg_recording()
              return ' recording to ' .. reg
            end,
            color = 'DiagnosticError',
            cond = function()
              return vim.fn.reg_recording() ~= ""
            end,
          }
        ''
        ''
          {
            "diff",
            colored = false,
            diff_color = {
              -- Same color values as the general color option can be used here.
              added    = 'DiffAdd',    -- Changes the diff's added color
              modified = 'DiffChange', -- Changes the diff's modified color
              removed  = 'DiffDelete', -- Changes the diff's removed color you
            },
            symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the diff symbols
            separator = {right = ''}
          }
        ''
      ];
      lualine.activeSection.b = [
        ''
          {
            "filetype",
            colored = true,
            icon_only = true,
            icon = { align = 'left' }
          }
        ''
        ''
          {
            "filename",
            symbols = {modified = ' ', readonly = ' '},
            separator = {right = ''}
          }
        ''
        ''
          {
            "",
            draw_empty = true,
            separator = { left = '', right = '' }
          }
        ''
      ];
    };

    languages = {
      enableTreesitter = true;
      enableFormat = true;
      enableDAP = true;

      bash.enable = true;

      python.enable = true;
      python.dap.enable = true;

      markdown.enable = true;

      nix.enable = true;
      nix.format.enable = true;

      lua.enable = true;

      clang.enable = true;
      clang.dap.enable = true;

      typst.enable = true;
      typst.format.enable = true;
      typst.lsp.enable = true;
    };

    debugger.nvim-dap.enable = true;
    debugger.nvim-dap.ui.enable = true;
    debugger.nvim-dap.mappings = let
      dKey = "<leader>d";
    in {
      continue = dKey + "c";
      goDown = dKey + "j";
      goUp = dKey + "k";
      hover = dKey + "h";
      restart = dKey + "re";
      runLast = dKey + ".";
      runToCursor = dKey + "rc";
      stepBack = dKey + "ba";
      stepInto = dKey + "I";
      stepOut = dKey + "ou";
      stepOver = dKey + "ov";
      terminate = dKey + "te";
      toggleBreakpoint = dKey + "br";
      toggleDapUI = dKey + "tu";
      toggleRepl = dKey + "rp";
    };

    autocomplete.blink-cmp = {
      enable = true;
    };

    formatter.conform-nvim = {
      enable = true;
    };
  };
}
