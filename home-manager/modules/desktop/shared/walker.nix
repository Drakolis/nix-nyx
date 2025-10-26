{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    walker
    inputs.iwmenu.packages.${pkgs.system}.default
    inputs.bzmenu.packages.${pkgs.system}.default
    rink
  ];

  xdg.configFile = {
    "walker/themes/drakolis.css".text = ''
      @define-color mantle #181825;
      @define-color text #cdd6f4;
      @define-color primary #cba6f7;
      @define-color error #f38ba8;
      @define-color surface0 #313244;

      #window,
      #box,
      #aiScroll,
      #aiList,
      #search,
      #password,
      #input,
      #prompt,
      #clear,
      #typeahead,
      #list,
      child,
      scrollbar,
      slider,
      #item,
      #text,
      #label,
      #bar,
      #sub,
      #activationlabel {
        all: unset;
      }

      #cfgerr {
        background: @error;
        margin-top: 20px;
        padding: 8px;
        font-size: 1.2em;
      }

      #window {
        color: @text;
      }

      #box {
        border-radius: 10px;
        background: @mantle;
        padding: 32px;
        border: 2px solid @primary;
        box-shadow:
          0 19px 38px rgba(0, 0, 0, 0.3),
          0 15px 12px rgba(0, 0, 0, 0.22);
      }

      #search {
        /* box-shadow:
          0 1px 3px rgba(0, 0, 0, 0.1),
          0 1px 2px rgba(0, 0, 0, 0.22); */
        background: @surface0;
        padding: 8px;
        border-radius: 7px;
      }

      #prompt {
        margin-left: 5px;
        margin-right: 10px;
        color: @text;
        opacity: 0.2;
      }

      #clear {
        color: @text;
      }

      #password,
      #input,
      #typeahead {
        border-radius: 2px;
      }

      #input {
        background: none;
      }

      #password {}

      #spinner {
        padding: 8px;
      }

      #typeahead {
        color: @text;
        opacity: 0.8;
      }

      #input placeholder {
        opacity: 0.5;
      }

      #list {}

      child {
        padding: 8px;
        border-radius: 2px;
        border-left: 4px solid transparent;
      }

      child:selected,
      child:hover {
        background: alpha(@primary, 0.1);
        border-left: 4px solid @primary;
      }

      #item {}

      #icon {
        margin-right: 5px;
      }

      #text {}

      #label {
        font-weight: bolder;
      }

      #sub {
        opacity: 0.5;
        font-size: smaller;
      }

      #activationlabel {}

      #bar {}

      .barentry {}

      .activation #activationlabel {}

      .activation #text,
      .activation #icon,
      .activation #search {
        opacity: 0.5;
      }

      .aiItem {
        padding: 10px;
        border-radius: 2px;
        color: @text;
        background: @mantle;
      }

      .aiItem.user {
        padding-left: 0;
        padding-right: 0;
      }

      .aiItem.assistant {
        background: @surface0;
      }
    '';

    "walker/config.toml".text = ''
      app_launch_prefix = ""
      terminal_title_flag = ""
      locale = ""
      close_when_open = false
      theme = "drakolis"
      monitor = ""
      hotreload_theme = false
      as_window = false
      timeout = 0
      disable_click_to_close = false
      force_keyboard_focus = true

      [keys]
      accept_typeahead = ["tab"]
      trigger_labels = "lalt"
      next = ["down"]
      prev = ["up"]
      close = ["esc"]
      remove_from_history = ["shift backspace"]
      resume_query = ["ctrl r"]
      toggle_exact_search = ["ctrl m"]

      [keys.activation_modifiers]
      keep_open = "shift"
      alternate = "alt"

      [keys.ai]
      clear_session = ["ctrl x"]
      copy_last_response = ["ctrl c"]
      resume_session = ["ctrl r"]
      run_last_response = ["ctrl e"]

      [events]
      on_activate = ""
      on_selection = ""
      on_exit = ""
      on_launch = ""
      on_query_change = ""

      [list]
      dynamic_sub = true
      keyboard_scroll_style = "emacs"
      max_entries = 50
      show_initial_entries = true
      single_click = true
      visibility_threshold = 20
      placeholder = "No Results"

      [search]
      argument_delimiter = "#"
      placeholder = "Search..."
      delay = 0
      resume_last_query = false

      [activation_mode]
      labels = "qwertyuiop"

      [builtins.applications]
      weight = 5
      name = "applications"
      placeholder = "Applications"
      prioritize_new = false
      hide_actions_with_empty_query = true
      context_aware = true
      refresh = true
      show_sub_when_single = true
      show_icon_when_single = true
      show_generic = true
      history = true

      [builtins.applications.actions]
      enabled = true
      hide_category = false
      hide_without_query = true

      [builtins.bookmarks]
      weight = 5
      placeholder = "Bookmarks"
      name = "bookmarks"
      icon = "bookmark"
      switcher_only = true

      [[builtins.bookmarks.entries]]
      label = "Walker"
      url = "https://github.com/abenz1267/walker"
      keywords = ["walker", "github"]

      [builtins.xdph_picker]
      weight = 5
      placeholder = "Screen/Window Picker"
      show_sub_when_single = true
      name = "xdphpicker"
      switcher_only = true

      [builtins.ai]
      weight = 5
      placeholder = "AI"
      name = "ai"
      icon = "help-browser"
      switcher_only = true

      [[builtins.ai.anthropic.prompts]]
      model = "claude-3-5-sonnet-2024102"
      temperature = 1
      max_tokens = 1_000
      label = "General Assistant"
      prompt = "You are a helpful general assistant. Keep your answers short and precise."

      [builtins.calc]
      require_number = true
      weight = 5
      name = "calc"
      icon = "accessories-calculator"
      placeholder = "Calculator"
      min_chars = 4

      [builtins.windows]
      weight = 5
      icon = "view-restore"
      name = "windows"
      placeholder = "Windows"
      show_icon_when_single = true

      [builtins.clipboard]
      always_put_new_on_top = true
      exec = "wl-copy"
      weight = 5
      name = "clipboard"
      avoid_line_breaks = true
      placeholder = "Clipboard"
      image_height = 300
      max_entries = 10
      switcher_only = true

      [builtins.commands]
      weight = 5
      icon = "utilities-terminal"
      switcher_only = true
      name = "commands"
      placeholder = "Commands"

      [builtins.custom_commands]
      weight = 5
      icon = "utilities-terminal"
      name = "custom_commands"
      placeholder = "Custom Commands"

      [builtins.emojis]
      exec = "wl-copy"
      weight = 5
      name = "emojis"
      placeholder = "Emojis"
      switcher_only = true
      history = true
      typeahead = true
      show_unqualified = false

      [builtins.symbols]
      after_copy = ""
      weight = 5
      name = "symbols"
      placeholder = "Symbols"
      switcher_only = true
      history = true
      typeahead = true

      [builtins.finder]
      use_fd = false
      weight = 5
      icon = "file"
      name = "finder"
      placeholder = "Finder"
      switcher_only = true
      ignore_gitignore = true
      refresh = true
      concurrency = 8
      show_icon_when_single = true
      preview_images = false

      [builtins.runner]
      eager_loading = true
      weight = 5
      icon = "utilities-terminal"
      name = "runner"
      placeholder = "Runner"
      typeahead = true
      history = true
      generic_entry = false
      refresh = true
      use_fd = false

      [builtins.ssh]
      weight = 5
      icon = "preferences-system-network"
      name = "ssh"
      placeholder = "SSH"
      switcher_only = true
      history = true
      refresh = true

      [builtins.switcher]
      weight = 5
      name = "switcher"
      placeholder = "Switcher"
      show_icon_when_single = true
      prefix = ":"

      [builtins.websearch]
      weight = 5
      icon = "applications-internet"
      name = "websearch"
      placeholder = "Websearch"

      [[builtins.websearch.entries]]
      name = "Ecosia"
      url = "https://www.ecosia.org/search?q=%TERM%"

      [[builtins.websearch.entries]]
      name = "NixOS Packages"
      url = "https://search.nixos.org/packages?channel=unstable&size=50&sort=relevance&type=packages&query=%TERM%"

      [[builtins.websearch.entries]]
      name = "NixOS Settings"
      url = "https://search.nixos.org/options?channel=unstable&size=50&sort=relevance&type=packages&query=%TERM%"

      [[builtins.websearch.entries]]
      name = "Google"
      url = "https://www.google.com/search?q=%TERM%"
      switcher_only = true

      [[builtins.websearch.entries]]
      name = "DuckDuckGo"
      url = "https://duckduckgo.com/?q=%TERM%"
      switcher_only = true

      [[builtins.websearch.entries]]
      name = "Wikipedia"
      url = "https://www.ecosia.org/search?q=%TERM%"
      switcher_only = true

      [[builtins.websearch.entries]]
      name = "Yandex"
      url = "https://yandex.com/search/?text=%TERM%"
      switcher_only = true

      [builtins.dmenu]
      hidden = true
      weight = 5
      name = "dmenu"
      placeholder = "Dmenu"
      switcher_only = true

      [builtins.translation]
      delay = 1000
      weight = 5
      name = "translation"
      placeholder = "Translation"
      switcher_only = true
      provider = "googlefree"
    '';
  };

  systemd.user.services.walker = {
    Unit = {
      Description = "Walker GApplication";
    };
    Service = {
      ExecStart = "/home/drakolis/.nix-profile/bin/walker --gapplication-service";
      Type = "simple";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
