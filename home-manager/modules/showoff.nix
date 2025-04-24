{ pkgs, ... }: {
  home.packages = with pkgs; [ lolcat ];

  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "transgender";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.65;
      color_align = {
        mode = "horizontal";
        custom_colors = [ ];
        fore_back = null;
      };
      backend = "neofetch";
      args = null;
      distro = null;
      pride_month_shown = [ ];
      pride_month_disable = false;
    };
  };

  programs.cava = {
    enable = true;
    settings = { };
  };

  # NeoFetch
  xdg.configFile = {
    "neofetch/config.conf".text = ''
      print_info() {
        info title
        info underline

        info "OS" distro
        info "Kernel" kernel
        info "Uptime" uptime
        info "Packages" packages
        info "Shell" shell
        info "Editor" editor
        info "Terminal" term

        # info underline

        # info "CPU" cpu
        # info "BIOS" bios
        # info "GPU" gpu
        # info "GPU Driver" gpu_driver  # Linux/macOS only
        info "DE" de
        info "WM" wm
        info "Resolution" resolution
        # info "Memory" memory
        # info "Disk" disk
        # info "Local IP" local_ip
        # info "Public IP" public_ip
        # info "Bluetooth" bluetooth
        # info "Battery" battery
        # info "Power Adapter" power_adapter # macOS only

        # info underline

        info "Java" java_ver
        info "Python" python_ver
        info "Node" node_ver

        info cols
      }

      title_fqdn="on"
      kernel_shorthand="on"
      distro_shorthand="off"
      os_arch="on"
      uptime_shorthand="on"
      memory_percent="on"
      memory_unit="gib"
      mem_precision=2
      package_managers="on"
      package_separate="on"
      package_minimal="default"
      shell_path="off"
      shell_version="on"
      editor_path="off"
      editor_version="on"
      speed_type="bios_limit"
      speed_shorthand="on"
      cpu_brand="on"
      cpu_speed="on"
      cpu_cores="logical"
      cpu_temp="on"
      gpu_brand="on"
      gpu_type="all"
      refresh_rate="on"
      gtk_shorthand="off"
      gtk2="on"
      gtk3="on"
      qt="on"
      public_ip_host="http://ident.me"
      public_ip_timeout=2
      local_ip_interface=('auto')
      de_version="on"
      disk_show=('/' '/home/')
      disk_subtitle="mount"
      disk_percent="on"
      music_player="auto"
      song_format="%artist% - %album% - %title%"
      song_shorthand="off"
      mpc_args=()
      colors=(distro)
      bold="on"
      underline_enabled="on"
      underline_char="-"
      separator=":"
      block_range=(0 15)
      color_blocks="on"
      block_width=3
      block_height=1
      col_offset="auto"
      bar_char_elapsed="="
      bar_char_total="-"
      bar_border="on"
      bar_length=15
      bar_color_elapsed="distro"
      bar_color_total="distro"
      memory_display="barinfo"
      battery_display="barinfo"
      disk_display="barinfo"
      image_backend="ascii"
      image_source="auto"
      ascii_distro="auto"
      ascii_colors=(distro)
      ascii_bold="on"
      image_loop="off"
      thumbnail_dir="''${XDG_CACHE_HOME:-''${HOME}/.cache}/thumbnails/neofetch"
      crop_mode="normal"
      crop_offset="center"
      image_size="auto"
      catimg_size="2"
      gap=3
      yoffset=0
      xoffset=0
      background_color=
      stdout="auto"
    '';
  };

}
