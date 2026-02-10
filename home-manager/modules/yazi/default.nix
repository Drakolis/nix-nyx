let
  style = import ../../../shared/constants/style.nix;
in
{
  imports = [ ./icons.nix ];
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    keymap = {
      manager.prepend_keymap = [
        {
          on = "M";
          run = "plugin mount";
          desc = "Mount plugin";
        }
      ];
    };
    initLua = ''
      require("full-border"):setup {
      	type = ui.Border.ROUNDED,
      }
    '';
    yaziPlugins = {
      enable = true;
      plugins = {
        starship.enable = true;
        full-border.enable = true;
        smart-filter.enable = true;
        relative-motions = {
          enable = true;
          show_numbers = "relative_absolute";
          show_motion = true;
        };
        jump-to-char = {
          enable = true;
          keys.toggle.on = [ "F" ];
        };
      };
    };
    settings = {
      mgr = {
        ratio = [
          1
          4
          3
        ];
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = true;
        linemode = "none";
        show_hidden = false;
        show_symlink = true;
        scrolloff = 5;
        mouse_events = [
          "click"
          "scroll"
        ];
        title_format = "󰇥 yazi: {cwd}";
      };
      preview = {
        wrap = "no";
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        image_delay = 30;
        image_filter = "triangle";
        image_quality = 75;
        sixel_fraction = 15;
        ueberzug_scale = 1;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };

      tasks = {
        micro_workers = 10;
        macro_workers = 10;
        bizarre_retry = 3;
        image_alloc = 536870912; # 512MB
        image_bound = [
          0
          0
        ];
        suppress_preload = false;
      };
    };
    theme = {
      mgr = {
        cwd = {
          fg = "#${style.colors.path}";
        };
        hovered = {
          fg = "#${style.colors.text}";
          bg = "#${style.colors.activeSurface}";
        };
        preview_hovered = {
          fg = "#${style.colors.text}";
          bg = "#${style.colors.activeSurface}";
        };
        find_keyword = {
          fg = "#${style.colors.modeSearch}";
          italic = true;
        };
        find_position = {
          fg = "#f5c2e7";
          bg = "reset";
          italic = true;
        };
        marker_copied = {
          fg = "#${style.colors.actionCopy}";
          bg = "#${style.colors.actionCopy}";
        };
        marker_cut = {
          fg = "#${style.colors.actionMove}";
          bg = "#${style.colors.actionMove}";
        };
        marker_marked = {
          fg = "#${style.colors.highlight}";
          bg = "#${style.colors.highlight}";
        };
        marker_selected = {
          fg = "#${style.colors.selection}";
          bg = "#${style.colors.selection}";
        };
        count_copied = {
          fg = "#${style.colors.textInverted}";
          bg = "#${style.colors.actionCopy}";
        };
        count_cut = {
          fg = "#${style.colors.textInverted}";
          bg = "#${style.colors.actionMove}";
        };
        count_selected = {
          fg = "#${style.colors.textInverted}";
          bg = "#${style.colors.selection}";
        };
        border_symbol = "│";
        border_style = {
          fg = "#${style.colors.tableLine}";
        };

        syntect_theme = "$HOME/.config/bat/themes/Catppuccin-mocha.tmTheme";
      };
      mode = {
        normal_main = {
          fg = "#${style.colors.textInverted}";
          bg = "#${style.colors.primary}";
          bold = true;
        };
        normal_alt = {
          fg = "#${style.colors.primary}";
          bg = "#${style.colors.modeInactive}";
        };
        select_main = {
          fg = "#${style.colors.textInverted}";
          bg = "#${style.colors.modeVisual}";
          bold = true;
        };
        select_alt = {
          fg = "#${style.colors.modeVisual}";
          bg = "#${style.colors.modeInactive}";
        };
        unset_main = {
          fg = "#${style.colors.textInverted}";
          bg = "#${style.colors.modeReplace}";
          bold = true;
        };
        unset_alt = {
          fg = "#${style.colors.modeReplace}";
          bg = "#${style.colors.modeInactive}";
        };
      };
      indicator = {
        parent = {
          fg = "#${style.colors.primary}";
          bg = "#${style.colors.activeSurface}";
        };
        current = {
          fg = "#${style.colors.primary}";
          bg = "#${style.colors.activeSurface}";
        };
        preview = {
          fg = "#${style.colors.primary}";
          bg = "#${style.colors.activeSurface}";
        };
        padding = {
          open = "█";
          close = "█";
        };
      };
      tabs = {
        active = {
          fg = "#${style.colors.textInverted}";
          bg = "#${style.colors.primary}";
        };
        inactive = {
          fg = "#${style.colors.textInverted}";
          bg = "#${style.colors.activeSurface}";
        };
        sep_inner = {
          open = "[";
          close = "]";
        };
        sep_outer = {
          open = "";
          close = "";
        };
      };
      status = {
        sep_left = {
          open = "";
          close = "";
        };
        sep_right = {
          open = "";
          close = "";
        };
        progress_label = {
          fg = "#${style.colors.textInverted}";
          bold = true;
        };

        progress_normal = {
          fg = "#${style.colors.textInverted}";
          bg = "#${style.colors.primary}";
        };

        progress_error = {
          fg = "#${style.colors.textInverted}";
          bg = "#${style.colors.error}";
        };

        perm_type = {
          fg = "#${style.colors.permissionType}";
        };
        perm_read = {
          fg = "#${style.colors.permissionRead}";
        };
        perm_write = {
          fg = "#${style.colors.permissionWrite}";
        };
        perm_exec = {
          fg = "#${style.colors.permissionExec}";
        };
        perm_sep = {
          fg = "#${style.colors.permissionEmpty}";
        };
      };
      input = {
        border = {
          fg = "#${style.colors.primary}";
        };
        title = {
          fg = "#${style.colors.text}";
        };
        value = { };
        selected = {
          reversed = true;
        };
      };
      pick = {
        border = {
          fg = "#${style.colors.primary}";
        };
        active = {
          fg = "#${style.colors.selection}";
        };
        inactive = { };
      };
      confirm = {
        border = {
          fg = "#${style.colors.primary}";
        };
        title = {
          fg = "#${style.colors.text}";
        };
        content = { };
        list = { };
        btn_yes = {
          reversed = true;
        };
        btn_no = { };
      };
      completion = {
        border = {
          fg = "#${style.colors.primary}";
        };
      };
      tasks = {
        border = {
          fg = "#${style.colors.primary}";
        };
        title = {
          fg = "#${style.colors.text}";
        };
        hovered = {
          underline = true;
        };
      };
      which = {
        mask = {
          bg = "#${style.colors.panel}";
        };
        cand = {
          fg = "#${style.colors.primary}";
        };
        rest = {
          fg = "#${style.colors.tableLine}";
        };
        desc = {
          fg = "#${style.colors.text}";
        };
        separator = "  ";
        separator_style = {
          fg = "#${style.colors.textGray}";
        };
      };
      help = {
        on = {
          fg = "#${style.colors.primary}";
        };
        run = {
          fg = "#${style.colors.info}";
        };
        desc = {
          fg = "#${style.colors.text}";
        };
        hovered = {
          bg = "#${style.colors.activeSurface}";
          bold = true;
        };
        footer = {
          fg = "#${style.colors.text}";
          bg = "#${style.colors.background}";
          bold = true;
        };
      };
      notify = {
        title_info = {
          fg = "#${style.colors.info}";
        };
        title_warn = {
          fg = "#${style.colors.warning}";
        };
        title_error = {
          fg = "#${style.colors.error}";
        };
      };

      filetype = {
        rules = [
          # Media
          {
            mime = "image/*";
            fg = "#${style.colors.filetypeImage}";
          }
          {
            mime = "{audio,video}/*";
            fg = "#${style.colors.filetypeVideo}";
          }

          # Archives
          {
            mime = "application/*zip";
            fg = "#${style.colors.filetypeArchive}";
          }
          {
            mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}";
            fg = "#${style.colors.filetypeArchive}";
          }

          # Documents
          {
            mime = "application/{pdf,doc,rtf}";
            fg = "#${style.colors.filetypeDocument}";
          }

          # Fallback
          {
            name = "*";
            fg = "#${style.colors.filetypeAny}";
          }
          {
            name = "*/";
            fg = "#${style.colors.filetypeFolder}";
          }
        ];
      };
    };
  };
}
