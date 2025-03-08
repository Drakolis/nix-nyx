{ lib, pkgs, ... }:

let style = import ../../constants/style.nix;
in {
  home.packages = with pkgs; [
    # Git
    # gitui

    # Docker
    docker
    docker-compose
    colima

    tokei

    wireshark-qt

    beekeeper-studio
    bruno
    hoppscotch

    # IDEs
    jetbrains.idea-community-bin
    # kdePackages.kate
    vscodium

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

  programs.gitui = {
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
}
