{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.development;
in
with lib;
{
  config = mkIf cfg.enable {
    programs.vscode = {
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
          pkgs.vscode-marketplace.miguelsolorio.symbols

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
          "[json]" = {
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
          "workbench.iconTheme" = "symbols";
          "workbench.preferredDarkColorTheme" = "Catppuccin Mocha";
          "workbench.preferredLightColorTheme" = "Catppuccin Latte";
          "workbench.sideBar.location" = "right";
          "workbench.startupEditor" = "none";
          "zenMode.hideLineNumbers" = false;
          "zenMode.hideStatusBar" = false;

          # EXTENSIONS

          "symbols.folders.associations" = {
            "entities" = "folder-assets";
            "files" = "folder-assets";
            "infra" = "folder-app";
            "schemas" = "folder-purple";
          };

          "symbols.files.associations" = {
            "app.module.ts" = "nest";
            "*.service.ts" = "nest-service";
            "*.controller.ts" = "nest-controller";
            "*.guard.ts" = "nest-guard";
          };

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

          # Tabby
          "tabby.endpoint" = "http://localhost:50000";
          "tabby.settings.advanced" = {
            "inlineCompletion.triggerMode" = "manual";
          };

          # Linters
          "xo.format.enable" = true;

          "cSpell.language" = "en,de,ru,pt";
        };
      };
    };
  };
}
