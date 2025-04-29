{ pkgs, ... }:
let
  style = import ../../constants/style.nix;
in
{
  home.packages = with pkgs; [
    # Support
    tokei

    # Runtime
    python3
    nodejs

    # CLI
    scaleway-cli

    # Docker
    docker
    docker-compose
    colima

    beekeeper-studio
    # bruno
    hoppscotch

    # IDEs
    jetbrains.idea-community-bin
    jetbrains.pycharm-community
    windsurf
    # kdePackages.kate

    # Language servers
    typescript-language-server
    yaml-language-server
    vue-language-server
    lua-language-server
    java-language-server
    docker-compose-language-service
    dockerfile-language-server-nodejs
    rust-analyzer
    terraform-ls
  ];

  nixpkgs.config.permittedInsecurePackages = [ "beekeeper-studio-5.1.5" ];

  programs = {

    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    gitui = {
      enable = true;
      theme = ''
        (
          selected_tab: Some("Reset"),
          command_fg: Some("#${style.colors.textInverted}"),
          selection_bg: Some("#${style.colors.selection}"),
          selection_fg: Some("#${style.colors.textInverted}"),
          cmdbar_bg: Some("#${style.colors.primary}"),
          cmdbar_extra_lines_bg: Some("#${style.colors.primary}"),
          disabled_fg: Some("#${style.colors.textGray}"),
          diff_line_add: Some("#${style.colors.gitAdded}"),
          diff_line_delete: Some("#${style.colors.gitRemoved}"),
          diff_file_added: Some("#${style.colors.gitAdded}"),
          diff_file_removed: Some("#${style.colors.gitRemoved}"),
          diff_file_moved: Some("#${style.colors.gitMoved}"),
          diff_file_modified: Some("#${style.colors.gitModified}"),
          commit_hash: Some("#${style.colors.gitCommit}"),
          commit_time: Some("#${style.colors.gitTime}"),
          commit_author: Some("#${style.colors.gitAuthor}"),
          danger_fg: Some("#${style.colors.error}"),
          push_gauge_bg: Some("#${style.colors.primary}"),
          push_gauge_fg: Some("#${style.colors.textInverted}"),
          tag_fg: Some("#${style.colors.gitTag}"),
          branch_fg: Some("#${style.colors.gitBranch}"),
        )
      '';
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
      profiles.default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;
        extensions = [
          # Nix
          pkgs.vscode-extensions.bbenoist.nix
          pkgs.vscode-extensions.jnoortheen.nix-ide
          pkgs.vscode-extensions.mkhl.direnv

          # Theming
          pkgs.vscode-extensions.catppuccin.catppuccin-vsc
          pkgs.vscode-extensions.catppuccin.catppuccin-vsc-icons

          # Everything
          pkgs.vscode-extensions.esbenp.prettier-vscode

          # NodeJS
          pkgs.vscode-extensions.firsttris.vscode-jest-runner
          pkgs.vscode-extensions.dbaeumer.vscode-eslint
          pkgs.vscode-marketplace.samverschueren.linter-xo
          pkgs.vscode-extensions.vue.volar
          pkgs.vscode-extensions.octref.vetur

          # Lua
          pkgs.vscode-marketplace.koihik.vscode-lua-format
          pkgs.vscode-extensions.sumneko.lua

          # Yuck
          pkgs.vscode-marketplace.eww-yuck.yuck

          # Markdown
          pkgs.vscode-extensions.yzhang.markdown-all-in-one
          pkgs.vscode-extensions.davidanson.vscode-markdownlint

          # Terraform
          pkgs.vscode-extensions.hashicorp.terraform

          # Databases
          pkgs.vscode-extensions.mongodb.mongodb-vscode
          pkgs.vscode-marketplace.mtxr.sqltools

          # Docker
          pkgs.vscode-extensions.ms-azuretools.vscode-docker

          # Cloud

          # Git
          pkgs.vscode-extensions.eamodio.gitlens

          # Editor
          pkgs.vscode-extensions.alefragnani.project-manager
          pkgs.vscode-extensions.gruntfuggly.todo-tree
          pkgs.vscode-extensions.streetsidesoftware.code-spell-checker
          pkgs.vscode-marketplace.streetsidesoftware.code-spell-checker-british-english
          pkgs.vscode-extensions.streetsidesoftware.code-spell-checker-german
          pkgs.vscode-marketplace.streetsidesoftware.code-spell-checker-portuguese-brazilian
          pkgs.vscode-marketplace.streetsidesoftware.code-spell-checker-russian
          pkgs.vscode-marketplace.streetsidesoftware.code-spell-checker-scientific-terms
          pkgs.vscode-marketplace.zokugun.cron-tasks
          # pkgs.vscode-extensions.vscodevim.vim
          pkgs.vscode-extensions.editorconfig.editorconfig

          pkgs.vscode-marketplace.tabbyml.vscode-tabby
        ];
        globalSnippets = { };
        languageSnippets = { };
        userSettings = {
          "[jsonc]" = {
            "editor.defaultFormatter" = "vscode.json-language-features";
          };
          "chat.commandCenter.enabled" = false;
          "diffEditor.ignoreTrimWhitespace" = false;
          "editor.fontFamily" = "'Hack Nerd Font', 'monospace', monospace";
          "editor.formatOnSave" = true;
          "editor.minimap.autohide" = true;
          "editor.tabCompletion" = "on";
          "editor.tabSize" = 2;
          "files.eol" = "\n";
          "files.insertFinalNewline" = true;
          "files.simpleDialog.enable" = true;
          "files.trimFinalNewlines" = true;
          "files.trimTrailingWhitespace" = true;
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "notebook.insertFinalNewline" = true;
          "window.autoDetectColorScheme" = true;
          "window.dialogStyle" = "custom";
          "window.titleBarStyle" = "custom";
          "workbench.colorTheme" = "Catppuccin Mocha";
          "workbench.editor.closeOnFileDelete" = true;
          "workbench.editor.highlightModifiedTabs" = true;
          "workbench.iconTheme" = "catppuccin-mocha";
          "workbench.preferredDarkColorTheme" = "Catppuccin Mocha";
          "workbench.preferredLightColorTheme" = "Catppuccin Frappé";
          "workbench.sideBar.location" = "right";
          "workbench.startupEditor" = "none";
          "zenMode.hideLineNumbers" = false;
          "zenMode.hideStatusBar" = false;

          # EXTENSIONS

          # Catppuccin Theme
          "catppuccin.italicKeywords" = false;

          # Nix Language
          "nix.enableLanguageServer" = false;
          "nix.formatterPath" = "nixfmt";
          "nix.serverPath" = "nil";

          # Lua Language
          "Lua.codeLens.enable" = true;
          "Lua.format.defaultConfig" = {
            "indent_style" = "space";
            "indent_size" = "2";
          };

          # GitLens
          "gitlens.advanced.messages" = {
            "suppressGitDisabledWarning" = true;
          };

          "cSpell.language" = "en,de,ru,pt";
          "tabby.endpoint" = "http://localhost:50000";
          "xo.format.enable" = true;
        };
      };
    };
  };
}
