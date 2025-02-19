{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Git
    # gitui

    # Docker
    docker
    docker-compose
    colima

    asdf-vm
    tokei

    beekeeper-studio
    bruno
    hoppscotch
    jetbrains.idea-community-bin
    # jetbrains.rust-rover
    # jetbrains.webstorm
    vscodium
    wireshark-qt
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
