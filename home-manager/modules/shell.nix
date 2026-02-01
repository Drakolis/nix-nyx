{ pkgs, ... }:
let
  style = import ../../shared/constants/style.nix;
  commands = import ../../shared/constants/commands.nix;
  paths = import ../../shared/constants/paths.nix;

  shellAliasesEza = {
    lsl = "eza -1la --icons=always --group-directories-first";
    lsg = "eza -Gla --icons=always --group-directories-first";
  };
  shellAliases = {
    nix-package-find = "nix --extra-experimental-features 'nix-command flakes' search nixpkgs ";
    nix-store-find = "ls /nix/store | fzf";
    nix-shell = "nix-shell --command zsh";
  };
in
{
  home.packages = [
    pkgs.exiftool
  ];

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

    shellAliases =
      shellAliases
      // shellAliasesEza
      // {
        fzyp = ''fzf --preview '${commands.previewTextInFzf}' ${commands.fzfPreviewOptions} --info-command 'echo "Search and Copy path: $PWD"' | xargs -I {} wl-copy $PWD/{}'';
        fzon = ''fzf --preview '${commands.previewTextInFzf}' ${commands.fzfPreviewOptions} --info-command 'echo "Search and Open in nvim: $PWD"' | xargs -I {} nvim $PWD/{}'';
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

  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
      completions.external = {
        enable = true;
        max_results = 200;
      };
      buffer_editor = "nvim";
    };
    shellAliases = shellAliases;
    plugins = [ ];
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
    enableNushellIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
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
        ssh_symbol = " 🌐";
        style = "bold green";
        format = "[$hostname$ssh_symbol]($style) in ";
      };
      shell = {
        disabled = false;
      };
    };
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

  programs.aichat.enable = true;

  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };
}
