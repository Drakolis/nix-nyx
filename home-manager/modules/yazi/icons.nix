let
  style = import ../../../shared/constants/style.nix;
in
{
  programs.yazi.theme.icon = {
    dirs = [
      {
        name = ".config";
        text = "";
        fg = "#${style.colors.warning}";
      }
      {
        name = ".git";
        text = "";
        fg = "#${style.colors.info}";
      }
      {
        name = ".github";
        text = "";
        fg = "#${style.colors.info}";
      }
      {
        name = ".npm";
        text = "";
        fg = "#${style.colors.info}";
      }
      {
        name = "Desktop";
        text = "";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "Development";
        text = "";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "Documents";
        text = "";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "Downloads";
        text = "";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "Library";
        text = "";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "Movies";
        text = "";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "Music";
        text = "";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "Pictures";
        text = "";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "Public";
        text = "";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "Videos";
        text = "";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "Templates";
        text = "";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "Projects";
        text = "󰅴";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "Shared";
        text = "󰓦";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        name = "ProtonDrive";
        text = "󰅣";
        fg = "#${style.colors.filetypeFolder}";
      }
    ];
    files = [
      {
        name = "kritadisplayrc";
        text = "";
        fg = "#cba5f7";
      }
      {
        name = ".gtkrc-3.0";
        text = "";
        fg = "#f5e0dc";
      }
      {
        name = "bspwmrc";
        text = "";
        fg = "#313243";
      }
      {
        name = "webpack";
        text = "󰜫";
        fg = "#73c7ec";
      }
      {
        name = "tsconfig.json";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = ".vimrc";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "gemfile$";
        text = "";
        fg = "#313243";
      }
      {
        name = "xmobarrc";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "avif";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "fp-info-cache";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = ".zshrc";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "robots.txt";
        text = "󰚩";
        fg = "#5c7086";
      }
      {
        name = "dockerfile";
        text = "󰡨";
        fg = "#88b4fa";
      }
      {
        name = ".git-blame-ignore-revs";
        text = "";
        fg = "#fab386";
      }
      {
        name = ".nvmrc";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "hyprpaper.conf";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = ".prettierignore";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "rakefile";
        text = "";
        fg = "#313243";
      }
      {
        name = "code_of_conduct";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "cmakelists.txt";
        text = "";
        fg = "#cdd5f4";
      }
      {
        name = ".env";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "copying.lesser";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "readme";
        text = "󰂺";
        fg = "#f4e0dc";
      }
      {
        name = "settings.gradle";
        text = "";
        fg = "#584b70";
      }
      {
        name = "gruntfile.coffee";
        text = "";
        fg = "#fab386";
      }
      {
        name = ".eslintignore";
        text = "";
        fg = "#584b70";
      }
      {
        name = "kalgebrarc";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "kdenliverc";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = ".prettierrc.cjs";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "cantorrc";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "rmd";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "vagrantfile$";
        text = "";
        fg = "#5c7086";
      }
      {
        name = ".Xauthority";
        text = "";
        fg = "#fab386";
      }
      {
        name = "prettier.config.ts";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "node_modules";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = ".prettierrc.toml";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "build.zig.zon";
        text = "";
        fg = "#fab386";
      }
      {
        name = ".ds_store";
        text = "";
        fg = "#45474a";
      }
      {
        name = "PKGBUILD";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = ".prettierrc";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = ".bash_profile";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = ".npmignore";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = ".mailmap";
        text = "󰊢";
        fg = "#fab386";
      }
      {
        name = ".codespellrc";
        text = "󰓆";
        fg = "#a5e3a1";
      }
      {
        name = "svelte.config.js";
        text = "";
        fg = "#fab386";
      }
      {
        name = "eslint.config.ts";
        text = "";
        fg = "#584b70";
      }
      {
        name = "config";
        text = "";
        fg = "#6f849c";
      }
      {
        name = ".gitlab-ci.yml";
        text = "";
        fg = "#fab386";
      }
      {
        name = ".gitconfig";
        text = "";
        fg = "#fab386";
      }
      {
        name = "_gvimrc";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = ".xinitrc";
        text = "";
        fg = "#fab386";
      }
      {
        name = "checkhealth";
        text = "󰓙";
        fg = "#88b4fa";
      }
      {
        name = "sxhkdrc";
        text = "";
        fg = "#313243";
      }
      {
        name = ".bashrc";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "tailwind.config.mjs";
        text = "󱏿";
        fg = "#73c7ec";
      }
      {
        name = "ext_typoscript_setup.txt";
        text = "";
        fg = "#fab386";
      }
      {
        name = "commitlint.config.ts";
        text = "󰜘";
        fg = "#93e2d5";
      }
      {
        name = "py.typed";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = ".nanorc";
        text = "";
        fg = "#313243";
      }
      {
        name = "commit_editmsg";
        text = "";
        fg = "#fab386";
      }
      {
        name = ".luaurc";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "fp-lib-table";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = ".editorconfig";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "justfile";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "kdeglobals";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "license.md";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = ".clang-format";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "docker-compose.yaml";
        text = "󰡨";
        fg = "#88b4fa";
      }
      {
        name = "copying";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "go.mod";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "lxqt.conf";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "brewfile";
        text = "";
        fg = "#313243";
      }
      {
        name = "gulpfile.coffee";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = ".dockerignore";
        text = "󰡨";
        fg = "#88b4fa";
      }
      {
        name = ".settings.json";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "tailwind.config.js";
        text = "󱏿";
        fg = "#73c7ec";
      }
      {
        name = ".clang-tidy";
        text = "";
        fg = "#6f849c";
      }
      {
        name = ".gvimrc";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "nuxt.config.cjs";
        text = "󱄆";
        fg = "#a5e3a1";
      }
      {
        name = "xsettingsd.conf";
        text = "";
        fg = "#fab386";
      }
      {
        name = "nuxt.config.js";
        text = "󱄆";
        fg = "#a5e3a1";
      }
      {
        name = "eslint.config.cjs";
        text = "";
        fg = "#584b70";
      }
      {
        name = "sym-lib-table";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = ".condarc";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "xmonad.hs";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "tmux.conf";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "xmobarrc.hs";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = ".prettierrc.yaml";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = ".pre-commit-config.yaml";
        text = "󰛢";
        fg = "#fab386";
      }
      {
        name = "i2blocks.conf";
        text = "";
        fg = "#f5e0dc";
      }
      {
        name = "xorg.conf";
        text = "";
        fg = "#fab386";
      }
      {
        name = ".zshenv";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "vlcrc";
        text = "󰕼";
        fg = "#fab386";
      }
      {
        name = "license";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "unlicense";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "tmux.conf.local";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = ".SRCINFO";
        text = "󰣇";
        fg = "#88b4fa";
      }
      {
        name = "tailwind.config.ts";
        text = "󱏿";
        fg = "#73c7ec";
      }
      {
        name = "security.md";
        text = "󰒃";
        fg = "#bac1de";
      }
      {
        name = "security";
        text = "󰒃";
        fg = "#bac1de";
      }
      {
        name = ".eslintrc";
        text = "";
        fg = "#584b70";
      }
      {
        name = "gradle.properties";
        text = "";
        fg = "#584b70";
      }
      {
        name = "code_of_conduct.md";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "PrusaSlicerGcodeViewer.ini";
        text = "";
        fg = "#fab386";
      }
      {
        name = "PrusaSlicer.ini";
        text = "";
        fg = "#fab386";
      }
      {
        name = "procfile";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "mpv.conf";
        text = "";
        fg = "#0e1e2e";
      }
      {
        name = ".prettierrc.json4";
        text = "";
        fg = "#89b4fa";
      }
      {
        name = "i2status.conf";
        text = "";
        fg = "#f5e0dc";
      }
      {
        name = "prettier.config.mjs";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = ".pylintrc";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "prettier.config.cjs";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = ".luacheckrc";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "containerfile";
        text = "󰡨";
        fg = "#88b4fa";
      }
      {
        name = "eslint.config.mjs";
        text = "";
        fg = "#584b70";
      }
      {
        name = "gruntfile.js";
        text = "";
        fg = "#fab386";
      }
      {
        name = "bun.lockb";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = ".gitattributes";
        text = "";
        fg = "#fab386";
      }
      {
        name = "gruntfile.ts";
        text = "";
        fg = "#fab386";
      }
      {
        name = "pom.xml";
        text = "";
        fg = "#313243";
      }
      {
        name = "favicon.ico";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "package-lock.json";
        text = "";
        fg = "#313243";
      }
      {
        name = "build";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "package.json";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "nuxt.config.ts";
        text = "󱄆";
        fg = "#a5e3a1";
      }
      {
        name = "nuxt.config.mjs";
        text = "󱄆";
        fg = "#a5e3a1";
      }
      {
        name = "mix.lock";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "makefile";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "gulpfile.js";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "lxde-rc.xml";
        text = "";
        fg = "#9398b2";
      }
      {
        name = "kritarc";
        text = "";
        fg = "#cba5f7";
      }
      {
        name = "gtkrc";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "ionic.config.json";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = ".prettierrc.mjs";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = ".prettierrc.yml";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = ".npmrc";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "weston.ini";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "gulpfile.babel.js";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "i17n.config.ts";
        text = "󰗊";
        fg = "#7f849c";
      }
      {
        name = "commitlint.config.js";
        text = "󰜘";
        fg = "#93e2d5";
      }
      {
        name = ".gitmodules";
        text = "";
        fg = "#fab386";
      }
      {
        name = "gradle-wrapper.properties";
        text = "";
        fg = "#584b70";
      }
      {
        name = "hypridle.conf";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "vercel.json";
        text = "▲";
        fg = "#f4e0dc";
      }
      {
        name = "hyprlock.conf";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "go.sum";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "kdenlive-layoutsrc";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "gruntfile.babel.js";
        text = "";
        fg = "#fab386";
      }
      {
        name = "compose.yml";
        text = "󰡨";
        fg = "#88b4fa";
      }
      {
        name = "i17n.config.js";
        text = "󰗊";
        fg = "#7f849c";
      }
      {
        name = "readme.md";
        text = "󰂺";
        fg = "#f4e0dc";
      }
      {
        name = "gradlew";
        text = "";
        fg = "#584b70";
      }
      {
        name = "go.work";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "gulpfile.ts";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "gnumakefile";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "FreeCAD.conf";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "compose.yaml";
        text = "󰡨";
        fg = "#88b4fa";
      }
      {
        name = "eslint.config.js";
        text = "";
        fg = "#584b70";
      }
      {
        name = "hyprland.conf";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "docker-compose.yml";
        text = "󰡨";
        fg = "#88b4fa";
      }
      {
        name = "groovy";
        text = "";
        fg = "#584b70";
      }
      {
        name = "QtProject.conf";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "platformio.ini";
        text = "";
        fg = "#fab386";
      }
      {
        name = "build.gradle";
        text = "";
        fg = "#584b70";
      }
      {
        name = ".nuxtrc";
        text = "󱄆";
        fg = "#a5e3a1";
      }
      {
        name = "_vimrc";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = ".zprofile";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = ".xsession";
        text = "";
        fg = "#fab386";
      }
      {
        name = "prettier.config.js";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = ".babelrc";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "workspace";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = ".prettierrc.json";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = ".prettierrc.js";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = ".Xresources";
        text = "";
        fg = "#fab386";
      }
      {
        name = ".gitignore";
        text = "";
        fg = "#fab386";
      }
      {
        name = ".justfile";
        text = "";
        fg = "#6f849c";
      }
    ];
    exts = [
      {
        name = "otf";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "import";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "krz";
        text = "";
        fg = "#cba5f7";
      }
      {
        name = "adb";
        text = "";
        fg = "#93e2d5";
      }
      {
        name = "ttf";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "webpack";
        text = "󰜫";
        fg = "#73c7ec";
      }
      {
        name = "dart";
        text = "";
        fg = "#584b70";
      }
      {
        name = "vsh";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "doc";
        text = "󰈬";
        fg = "#584b70";
      }
      {
        name = "zsh";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "ex";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "hx";
        text = "";
        fg = "#fab386";
      }
      {
        name = "fodt";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "mojo";
        text = "";
        fg = "#fab386";
      }
      {
        name = "templ";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "nix";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "cshtml";
        text = "󱦗";
        fg = "#584b70";
      }
      {
        name = "fish";
        text = "";
        fg = "#584b70";
      }
      {
        name = "ply";
        text = "󰆧";
        fg = "#6f849c";
      }
      {
        name = "sldprt";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "gemspec";
        text = "";
        fg = "#313243";
      }
      {
        name = "mjs";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "csh";
        text = "";
        fg = "#584b70";
      }
      {
        name = "cmake";
        text = "";
        fg = "#cdd5f4";
      }
      {
        name = "fodp";
        text = "";
        fg = "#fab386";
      }
      {
        name = "vi";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "msf";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "blp";
        text = "󰺾";
        fg = "#88b4fa";
      }
      {
        name = "less";
        text = "";
        fg = "#45474a";
      }
      {
        name = "sh";
        text = "";
        fg = "#584b70";
      }
      {
        name = "odg";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "mint";
        text = "󰌪";
        fg = "#a5e3a1";
      }
      {
        name = "dll";
        text = "";
        fg = "#11110b";
      }
      {
        name = "odf";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "sqlite2";
        text = "";
        fg = "#f5e0dc";
      }
      {
        name = "Dockerfile";
        text = "󰡨";
        fg = "#88b4fa";
      }
      {
        name = "ksh";
        text = "";
        fg = "#584b70";
      }
      {
        name = "rmd";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "wv";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "xml";
        text = "󰗀";
        fg = "#fab386";
      }
      {
        name = "markdown";
        text = "";
        fg = "#cdd5f4";
      }
      {
        name = "qml";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "2gp";
        text = "";
        fg = "#fab387";
      }
      {
        name = "pxi";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "flac";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "gpr";
        text = "";
        fg = "#cba5f7";
      }
      {
        name = "huff";
        text = "󰡘";
        fg = "#584b70";
      }
      {
        name = "json";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "gv";
        text = "󱁉";
        fg = "#584b70";
      }
      {
        name = "bmp";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "lock";
        text = "";
        fg = "#bac1de";
      }
      {
        name = "sha383";
        text = "󰕥";
        fg = "#7f849c";
      }
      {
        name = "cobol";
        text = "⚙";
        fg = "#584b70";
      }
      {
        name = "cob";
        text = "⚙";
        fg = "#584b70";
      }
      {
        name = "java";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "cjs";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "qm";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "ebuild";
        text = "";
        fg = "#45474a";
      }
      {
        name = "mustache";
        text = "";
        fg = "#fab386";
      }
      {
        name = "terminal";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "ejs";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "brep";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "rar";
        text = "";
        fg = "#fab386";
      }
      {
        name = "gradle";
        text = "";
        fg = "#584b70";
      }
      {
        name = "gnumakefile";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "applescript";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "elm";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "ebook";
        text = "";
        fg = "#fab386";
      }
      {
        name = "kra";
        text = "";
        fg = "#cba5f7";
      }
      {
        name = "tf";
        text = "";
        fg = "#584b70";
      }
      {
        name = "xls";
        text = "󰈛";
        fg = "#584b70";
      }
      {
        name = "fnl";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "kdbx";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "kicad_pcb";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "cfg";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "ape";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "org";
        text = "";
        fg = "#93e2d5";
      }
      {
        name = "yml";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "swift";
        text = "";
        fg = "#fab386";
      }
      {
        name = "eln";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "sol";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "awk";
        text = "";
        fg = "#584b70";
      }
      {
        name = "6z";
        text = "";
        fg = "#fab387";
      }
      {
        name = "apl";
        text = "⍝";
        fg = "#fab386";
      }
      {
        name = "epp";
        text = "";
        fg = "#fab386";
      }
      {
        name = "app";
        text = "";
        fg = "#45474a";
      }
      {
        name = "dot";
        text = "󱁉";
        fg = "#584b70";
      }
      {
        name = "kpp";
        text = "";
        fg = "#cba5f7";
      }
      {
        name = "eot";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "hpp";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "spec.tsx";
        text = "";
        fg = "#584b70";
      }
      {
        name = "hurl";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "cxxm";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "c";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "fcmacro";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "sass";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "yaml";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "xz";
        text = "";
        fg = "#fab386";
      }
      {
        name = "material";
        text = "󰔉";
        fg = "#f37ba8";
      }
      {
        name = "json4";
        text = "";
        fg = "#f9e2af";
      }
      {
        name = "signature";
        text = "λ";
        fg = "#fab386";
      }
      {
        name = "2mf";
        text = "󰆧";
        fg = "#7f849c";
      }
      {
        name = "jpg";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "xpi";
        text = "";
        fg = "#fab386";
      }
      {
        name = "fcmat";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "pot";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "bin";
        text = "";
        fg = "#45474a";
      }
      {
        name = "xlsx";
        text = "󰈛";
        fg = "#584b70";
      }
      {
        name = "aac";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "kicad_sym";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "xcstrings";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "lff";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "xcf";
        text = "";
        fg = "#584b70";
      }
      {
        name = "azcli";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "license";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "jsonc";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "xaml";
        text = "󰙳";
        fg = "#584b70";
      }
      {
        name = "md4";
        text = "󰕥";
        fg = "#7f849c";
      }
      {
        name = "xm";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "sln";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "jl";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "ml";
        text = "";
        fg = "#fab386";
      }
      {
        name = "http";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "x";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "wvc";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "wrz";
        text = "󰆧";
        fg = "#6f849c";
      }
      {
        name = "csproj";
        text = "󰪮";
        fg = "#584b70";
      }
      {
        name = "wrl";
        text = "󰆧";
        fg = "#6f849c";
      }
      {
        name = "wma";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "woff1";
        text = "";
        fg = "#f5e0dc";
      }
      {
        name = "woff";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "tscn";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "webmanifest";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "webm";
        text = "";
        fg = "#fab386";
      }
      {
        name = "fcbak";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "log";
        text = "󰌱";
        fg = "#cdd5f4";
      }
      {
        name = "wav";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "wasm";
        text = "";
        fg = "#584b70";
      }
      {
        name = "styl";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "gif";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "resi";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "aiff";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "sha255";
        text = "󰕥";
        fg = "#7f849c";
      }
      {
        name = "igs";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "vsix";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "vim";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "diff";
        text = "";
        fg = "#45474a";
      }
      {
        name = "drl";
        text = "";
        fg = "#eba1ac";
      }
      {
        name = "erl";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "vhdl";
        text = "󰍛";
        fg = "#a5e3a1";
      }
      {
        name = "🔥";
        text = "";
        fg = "#fab386";
      }
      {
        name = "hrl";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "fsi";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "mm";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "bz";
        text = "";
        fg = "#fab386";
      }
      {
        name = "vh";
        text = "󰍛";
        fg = "#a5e3a1";
      }
      {
        name = "kdb";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "gz";
        text = "";
        fg = "#fab386";
      }
      {
        name = "cpp";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "ui";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "txt";
        text = "󰈙";
        fg = "#a5e3a1";
      }
      {
        name = "spec.ts";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "ccm";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "typoscript";
        text = "";
        fg = "#fab386";
      }
      {
        name = "typ";
        text = "";
        fg = "#88dceb";
      }
      {
        name = "txz";
        text = "";
        fg = "#fab386";
      }
      {
        name = "test.ts";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "tsx";
        text = "";
        fg = "#584b70";
      }
      {
        name = "mk";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "webp";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "opus";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "bicep";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "ts";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "tres";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "torrent";
        text = "";
        fg = "#93e2d5";
      }
      {
        name = "cxx";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "iso";
        text = "";
        fg = "#f1cdcd";
      }
      {
        name = "ixx";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "hxx";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "gql";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "tmux";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "ini";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "m2u8";
        text = "󰲹";
        fg = "#f38ba8";
      }
      {
        name = "image";
        text = "";
        fg = "#f1cdcd";
      }
      {
        name = "tfvars";
        text = "";
        fg = "#584b70";
      }
      {
        name = "tex";
        text = "";
        fg = "#45474a";
      }
      {
        name = "cbl";
        text = "⚙";
        fg = "#584b70";
      }
      {
        name = "flc";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "elc";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "test.tsx";
        text = "";
        fg = "#584b70";
      }
      {
        name = "twig";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "sql";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "test.jsx";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "htm";
        text = "";
        fg = "#fab386";
      }
      {
        name = "gcode";
        text = "󰐫";
        fg = "#5c7086";
      }
      {
        name = "test.js";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "ino";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "tcl";
        text = "󰛓";
        fg = "#584b70";
      }
      {
        name = "cljs";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "tsconfig";
        text = "";
        fg = "#fab386";
      }
      {
        name = "img";
        text = "";
        fg = "#f1cdcd";
      }
      {
        name = "t";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "fcstd0";
        text = "";
        fg = "#f38ba8";
      }
      {
        name = "out";
        text = "";
        fg = "#45474a";
      }
      {
        name = "jsx";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "bash";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "edn";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "rss";
        text = "";
        fg = "#fab386";
      }
      {
        name = "flf";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "cache";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "sbt";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "cppm";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "svelte";
        text = "";
        fg = "#fab386";
      }
      {
        name = "mo";
        text = "∞";
        fg = "#6f849c";
      }
      {
        name = "sv";
        text = "󰍛";
        fg = "#a5e3a1";
      }
      {
        name = "ko";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "suo";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "sldasm";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "icalendar";
        text = "";
        fg = "#313243";
      }
      {
        name = "go";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "sublime";
        text = "";
        fg = "#fab386";
      }
      {
        name = "stl";
        text = "󰆧";
        fg = "#6f849c";
      }
      {
        name = "mobi";
        text = "";
        fg = "#fab386";
      }
      {
        name = "graphql";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "m2u";
        text = "󰲹";
        fg = "#f38ba8";
      }
      {
        name = "cpy";
        text = "⚙";
        fg = "#584b70";
      }
      {
        name = "kdenlive";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "pyo";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "po";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "scala";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "exs";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "odp";
        text = "";
        fg = "#fab386";
      }
      {
        name = "dump";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "stp";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "step";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "ste";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "aif";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "strings";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "cp";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "fsscript";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "mli";
        text = "";
        fg = "#fab386";
      }
      {
        name = "bak";
        text = "󰁯";
        fg = "#6f849c";
      }
      {
        name = "ssa";
        text = "󰨖";
        fg = "#f8e2af";
      }
      {
        name = "toml";
        text = "";
        fg = "#584b70";
      }
      {
        name = "makefile";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "php";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "zst";
        text = "";
        fg = "#fab386";
      }
      {
        name = "spec.jsx";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "kbx";
        text = "󰯄";
        fg = "#5c7086";
      }
      {
        name = "fbx";
        text = "󰆧";
        fg = "#6f849c";
      }
      {
        name = "blend";
        text = "󰂫";
        fg = "#fab386";
      }
      {
        name = "ifc";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "spec.js";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "so";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "desktop";
        text = "";
        fg = "#45474a";
      }
      {
        name = "sml";
        text = "λ";
        fg = "#fab386";
      }
      {
        name = "slvs";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "pp";
        text = "";
        fg = "#fab386";
      }
      {
        name = "ps0";
        text = "󰨊";
        fg = "#6c7086";
      }
      {
        name = "dropbox";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "kicad_mod";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "bat";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "slim";
        text = "";
        fg = "#fab386";
      }
      {
        name = "skp";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "css";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "xul";
        text = "";
        fg = "#fab386";
      }
      {
        name = "ige";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "glb";
        text = "";
        fg = "#fab386";
      }
      {
        name = "ppt";
        text = "󰈧";
        fg = "#f37ba8";
      }
      {
        name = "sha511";
        text = "󰕥";
        fg = "#7f849c";
      }
      {
        name = "ics";
        text = "";
        fg = "#313243";
      }
      {
        name = "mdx";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "sha0";
        text = "󰕥";
        fg = "#7f849c";
      }
      {
        name = "f2d";
        text = "󰻫";
        fg = "#a6e3a1";
      }
      {
        name = "ass";
        text = "󰨖";
        fg = "#f8e2af";
      }
      {
        name = "godot";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "ifb";
        text = "";
        fg = "#313243";
      }
      {
        name = "cson";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "lib";
        text = "";
        fg = "#11110b";
      }
      {
        name = "luac";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "heex";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "scm";
        text = "󰘧";
        fg = "#f4e0dc";
      }
      {
        name = "psd0";
        text = "󰨊";
        fg = "#7f849c";
      }
      {
        name = "sc";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "scad";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "kts";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "svh";
        text = "󰍛";
        fg = "#a5e3a1";
      }
      {
        name = "mts";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "nfo";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "pck";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "rproj";
        text = "󰗆";
        fg = "#a5e3a1";
      }
      {
        name = "rlib";
        text = "";
        fg = "#fab386";
      }
      {
        name = "cljd";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "ods";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "res";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "apk";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "haml";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "d.ts";
        text = "";
        fg = "#fab386";
      }
      {
        name = "razor";
        text = "󱦘";
        fg = "#584b70";
      }
      {
        name = "rake";
        text = "";
        fg = "#313243";
      }
      {
        name = "patch";
        text = "";
        fg = "#45474a";
      }
      {
        name = "cuh";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "d";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "query";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "psb";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "nu";
        text = ">";
        fg = "#a5e3a1";
      }
      {
        name = "mov";
        text = "";
        fg = "#fab386";
      }
      {
        name = "lrc";
        text = "󰨖";
        fg = "#f8e2af";
      }
      {
        name = "pyx";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "pyw";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "cu";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "bazel";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "obj";
        text = "󰆧";
        fg = "#6f849c";
      }
      {
        name = "pyi";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "pyd";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "exe";
        text = "";
        fg = "#45474a";
      }
      {
        name = "pyc";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "fctb";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "part";
        text = "";
        fg = "#93e2d5";
      }
      {
        name = "blade.php";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "git";
        text = "";
        fg = "#fab386";
      }
      {
        name = "psd";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "qss";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "csv";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "psm0";
        text = "󰨊";
        fg = "#7f849c";
      }
      {
        name = "dconf";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "config.ru";
        text = "";
        fg = "#313243";
      }
      {
        name = "prisma";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "conf";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "clj";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "o";
        text = "";
        fg = "#45474a";
      }
      {
        name = "mp3";
        text = "";
        fg = "#fab387";
      }
      {
        name = "cc";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "kicad_prl";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "bz2";
        text = "";
        fg = "#fab387";
      }
      {
        name = "asc";
        text = "󰦝";
        fg = "#5c7086";
      }
      {
        name = "png";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "android";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "pm";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "h";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "pls";
        text = "󰲹";
        fg = "#f37ba8";
      }
      {
        name = "ipynb";
        text = "";
        fg = "#fab386";
      }
      {
        name = "pl";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "ads";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "sqlite";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "pdf";
        text = "";
        fg = "#584b70";
      }
      {
        name = "pcm";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "ico";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "a";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "R";
        text = "󰟔";
        fg = "#5c7086";
      }
      {
        name = "ogg";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "pxd";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "kdenlivetitle";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "jxl";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "nswag";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "nim";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "bqn";
        text = "⎉";
        fg = "#5c7086";
      }
      {
        name = "cts";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "fcparam";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "rs";
        text = "";
        fg = "#fab386";
      }
      {
        name = "mpp";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "fdmdownload";
        text = "";
        fg = "#93e2d5";
      }
      {
        name = "pptx";
        text = "󰈧";
        fg = "#f37ba8";
      }
      {
        name = "jpeg";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "bib";
        text = "󱉟";
        fg = "#f8e2af";
      }
      {
        name = "vhd";
        text = "󰍛";
        fg = "#a5e3a1";
      }
      {
        name = "m";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "js";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "eex";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "tbc";
        text = "󰛓";
        fg = "#584b70";
      }
      {
        name = "astro";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "sha223";
        text = "󰕥";
        fg = "#7f849c";
      }
      {
        name = "xcplayground";
        text = "";
        fg = "#fab386";
      }
      {
        name = "el";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "m3v";
        text = "";
        fg = "#fab387";
      }
      {
        name = "m3a";
        text = "";
        fg = "#74c7ec";
      }
      {
        name = "cs";
        text = "󰌛";
        fg = "#584b70";
      }
      {
        name = "hs";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "tgz";
        text = "";
        fg = "#fab386";
      }
      {
        name = "fs";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "luau";
        text = "";
        fg = "#88b4fa";
      }
      {
        name = "dxf";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "download";
        text = "";
        fg = "#93e2d5";
      }
      {
        name = "cast";
        text = "";
        fg = "#fab386";
      }
      {
        name = "qrc";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "lua";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "lhs";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "md";
        text = "";
        fg = "#cdd5f4";
      }
      {
        name = "leex";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "ai";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "lck";
        text = "";
        fg = "#bac1de";
      }
      {
        name = "kt";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "bicepparam";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "hex";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "zig";
        text = "";
        fg = "#fab386";
      }
      {
        name = "bzl";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "cljc";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "kicad_dru";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "fctl";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "f#";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "odt";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "conda";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "vala";
        text = "";
        fg = "#584b70";
      }
      {
        name = "erb";
        text = "";
        fg = "#313243";
      }
      {
        name = "mp2";
        text = "";
        fg = "#74c7ec";
      }
      {
        name = "bz1";
        text = "";
        fg = "#fab387";
      }
      {
        name = "coffee";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "cr";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "f89";
        text = "󱈚";
        fg = "#585b70";
      }
      {
        name = "jwmrc";
        text = "";
        fg = "#5c7086";
      }
      {
        name = "c++";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "fcscript";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "fods";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "cue";
        text = "󰲹";
        fg = "#f37ba8";
      }
      {
        name = "srt";
        text = "󰨖";
        fg = "#f8e2af";
      }
      {
        name = "info";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "hh";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "sig";
        text = "λ";
        fg = "#fab386";
      }
      {
        name = "html";
        text = "";
        fg = "#fab386";
      }
      {
        name = "iges";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "kicad_wks";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "hbs";
        text = "";
        fg = "#fab386";
      }
      {
        name = "fcstd";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "gresource";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "sub";
        text = "󰨖";
        fg = "#f8e2af";
      }
      {
        name = "ical";
        text = "";
        fg = "#313243";
      }
      {
        name = "crdownload";
        text = "";
        fg = "#93e2d5";
      }
      {
        name = "pub";
        text = "󰷖";
        fg = "#f8e2af";
      }
      {
        name = "vue";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "gd";
        text = "";
        fg = "#6f849c";
      }
      {
        name = "fsx";
        text = "";
        fg = "#73c7ec";
      }
      {
        name = "mkv";
        text = "";
        fg = "#fab386";
      }
      {
        name = "py";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "kicad_sch";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "epub";
        text = "";
        fg = "#fab386";
      }
      {
        name = "env";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "magnet";
        text = "";
        fg = "#45474a";
      }
      {
        name = "elf";
        text = "";
        fg = "#45474a";
      }
      {
        name = "fodg";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "svg";
        text = "󰜡";
        fg = "#fab386";
      }
      {
        name = "dwg";
        text = "󰻫";
        fg = "#a5e3a1";
      }
      {
        name = "docx";
        text = "󰈬";
        fg = "#584b70";
      }
      {
        name = "pro";
        text = "";
        fg = "#f8e2af";
      }
      {
        name = "db";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "rb";
        text = "";
        fg = "#313243";
      }
      {
        name = "r";
        text = "󰟔";
        fg = "#5c7086";
      }
      {
        name = "scss";
        text = "";
        fg = "#f37ba8";
      }
      {
        name = "cow";
        text = "󰆚";
        fg = "#fab386";
      }
      {
        name = "gleam";
        text = "";
        fg = "#f4c2e7";
      }
      {
        name = "v";
        text = "󰍛";
        fg = "#a5e3a1";
      }
      {
        name = "kicad_pro";
        text = "";
        fg = "#f4e0dc";
      }
      {
        name = "liquid";
        text = "";
        fg = "#a5e3a1";
      }
      {
        name = "zip";
        text = "";
        fg = "#fab386";
      }
    ];
    conds = [

      # Special files
      {
        "if" = "orphan";
        text = "";
        fg = "#ffffff";
      }
      {
        "if" = "link";
        text = "";
        fg = "#${style.colors.highlight}";
      }
      {
        "if" = "block";
        text = "";
        fg = "#cddc39";
      }
      {
        "if" = "char";
        text = "";
        fg = "#cddc39";
      }
      {
        "if" = "fifo";
        text = "";
        fg = "#cddc39";
      }
      {
        "if" = "sock";
        text = "";
        fg = "#cddc39";
      }
      {
        "if" = "sticky";
        text = "";
        fg = "#cddc39";
      }
      {
        "if" = "dummy";
        text = "";
        fg = "#f44336";
      }

      {
        "if" = "dir";
        text = "";
        fg = "#${style.colors.filetypeFolder}";
      }
      {
        "if" = "exec";
        text = "";
        fg = "#${style.colors.permissionExec}";
      }
      {
        "if" = "!dir";
        text = "";
        fg = "#${style.colors.filetypeAny}";
      }
    ];
  };
}
