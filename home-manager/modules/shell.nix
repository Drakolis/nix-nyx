{ pkgs, ... }:
let
  style = import ../../constants/style.nix;
  commands = import ../../constants/commands.nix;
  paths = import ../../constants/paths.nix;
in
{
  home.packages = with pkgs; [ exiftool ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;

    autosuggestion = {
      enable = true;
    };

    dirHashes = {
      docs = paths.documents;
      vids = paths.videos;
      code = paths.projects;
      dl = paths.download;
      pics = paths.pictures;
      mus = paths.music;

      conf = paths.configuration;
      nyx = paths.nyxRepository;
    };

    shellAliases = {
      lsl = "eza -1la --icons=always --group-directories-first";
      lsg = "eza -Gla --icons=always --group-directories-first";
      nix-package-find = "nix --extra-experimental-features 'nix-command flakes' search nixpkgs ";
      fzyp = ''fzf --preview '${commands.previewTextInFzf}' ${commands.fzfPreviewOptions} --info-command 'echo "Search and Copy path: $PWD"' | xargs -I {} wl-copy $PWD/{}'';
      fzon = ''fzf --preview '${commands.previewTextInFzf}' ${commands.fzfPreviewOptions} --info-command 'echo "Search and Open in nvim: $PWD"' | xargs -I {} nvim $PWD/{}'';
      nix-store-find = "ls /nix/store | fzf";
    };

    history = {
      save = 10000;
      append = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };

    syntaxHighlighting = {
      enable = true;
    };

    "oh-my-zsh" = {
      enable = true;
      plugins = [
        "aliases"
        "copyfile"
        "dotenv"
        "fzf"
        "genpass"
        "git"
        "qrcode"
        "sudo"
      ];
    };

    initContent = ''
      function pet-select() {
        BUFFER=$(pet search --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle redisplay
      }
      zle -N pet-select
      stty -ixon
      bindkey '^s' pet-select
    '';
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    colors = {
      bg = "#${style.colors.background}";
      fg = "#${style.colors.text}";
      hl = "#${style.colors.highlight}";

      header = "#${style.colors.primary}";

      spinner = "#${style.colors.secondary}";
      info = "#${style.colors.info}";

      prompt = "#${style.colors.success}";
      marker = "#${style.colors.selection}";

      # Selected line
      pointer = "#${style.colors.primary}";
      "bg+" = "#${style.colors.activeSurface}";
      "fg+" = "#${style.colors.text}";
      "hl+" = "#${style.colors.highlight}";
    };
    fileWidgetOptions = [
      "--preview '${commands.previewTextInFzf}' ${commands.fzfPreviewOptions}"
    ];
    defaultOptions = [ "--multi" ];
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;
      time = {
        disabled = false;
      };
      sudo = {
        disabled = false;
      };
      username = {
        show_always = true;
        style_user = "bold purple";
        format = "[$user]($style)@"; # Followed by hostname
      };
      hostname = {
        ssh_only = false;
      };
    };
  };

  programs.zellij = {
    # enable = true;
    # enableBashIntegration = true;
    # enableZshIntegration = true;
    settings = { };
  };

  programs.navi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      style = {
        tag = {
          color = "yellow";
          width_percentage = 16;
          min_width = 20;
        };
        snippet = {
          color = "cyan";
          width_percentage = 32;
          min_width = 45;
        };
        comment = {
          color = "grey";
        };
      };
      cheats = {
        paths = [ "${paths.documents}/cheatsheets" ];
      };
      finder = {
        command = "fzf";
      };
      shell = {
        command = "zsh";
      };
    };
  };

  programs.translate-shell = {
    enable = true;
    settings = {
      hl = "en";
      tl = "de";
      verbose = false;
    };
  };

  programs.pet = {
    enable = true;
    settings = {
      General = {
        editor = commands.tui.editor;
        column = 40;
        selectcmd = "fzf"; # TODO: Move this out
        backend = "gitlab";
        sortby = "recency";
        cmd = [
          "sh"
          "-c"
        ];
        color = true;
        format = "[$description: $command]";
      };
      GitLab = {
        url = "https://gitlab.com";
        file_name = "snippet.toml";
        access_token = ""; # TODO: Replace this before comitting
        id = "4800544";
        visability = "private";
        auto_sync = true;
      };
    };
  };

  programs.tealdeer = {
    enable = true;
    settings = {
      display = {
        use_pager = true;
      };
      style = {
        description = { };
        example_text = {
          foreground = "blue";
        };
        command_name = {
          foreground = "green";
        };
        example_code = { };
        example_variable = {
          foreground = "cyan";
          underline = true;
        };
      };
      updates = {
        auto_update = true;
      };
    };
  };
}
