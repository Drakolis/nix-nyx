{ config, lib, pkgs, ... }:
let style = import ../../../constants/style.nix;
in {
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 750;
      height = 400;
      always_parse_args = true;
      show_all = false;
      term = "kitty";
      hide_scroll = true;
      print_command = true;
      insensitive = true;
      prompt = "";
      columns = 2;
      opacity = 0.97;
      theme = "./style.css";
      pre_display_exec = true;

      key_expand = "Tab";
    };
    style = ''
      * {
        font-size: ${toString style.fontSizeLarger}px;
        font-family: ${style.fontGui};
      }

      @keyframes fadeIn {
        0% {
          opacity: 0;
        }

        100% {
          opacity: 1;
        }
      }

      /* Window */
      window {
        margin: 0px;
        padding: 0px;
        background-color: alpha(#${style.colors.panel}, ${
          toString style.opacity.background.decimal
        });
        box-shadow: 0 0 3px 2px #${style.colors.shadow}, inset 0 0 0 ${
          toString style.border.inner.width
        }px #${style.colors.primary};
        border-radius: ${toString style.border.inner.radius}px;
        animation: fadeIn 0.25s ease-in-out both;
      }

      /* Inside the window */
      #outer-box {
        padding: 15px;
      }

      /* Selection options */
      #inner-box {
        padding: 10px;
      }

      /* Scroll view */
      #scroll {
        padding: 15px;
      }

      /* Input */
      #input {
        margin: 5px 20px;
        padding: 10px;
        color: #${style.colors.text};
        background-color: alpha(#${style.colors.activeSurface}, ${
          toString style.opacity.background.decimal
        });
      }

      #input image {
        border: none;
        color: #${style.colors.text};
        padding: 10px;
      }

      #input:focus {
        box-shadow: inset 0 0 0 ${
          toString style.border.inner.width
        }px #${style.colors.primary};
      }

      #entry #text {
        border: none;
        color: #${style.colors.text};
        padding: 10px 5px;
      }

      #entry #img {
        margin-left: 5px;
      }

      #entry {
        all: unset;
        box-shadow: none;
        color: #${style.colors.text};
        padding: 5px;
        border-radius: 20px;
        all: unset;
      }

      #entry arrow {
        color: #${style.colors.text};
        margin: 0px;
      }

      #entry:selected {
        border-left: solid 3px #${style.colors.primary};
        color: #${style.colors.text};
        background: alpha(#${style.colors.primary}, 0.1);
        box-shadow: none;
      }

      #entry:selected #text {
        border: none;
        box-shadow: none;
        background: none;
        color: #${style.colors.primary};
      }

      #entry:selected image {
        border: none;
        box-shadow: none;
        background: none;
      }

      #entry #text:focus {
        border: none;
        box-shadow: none;
      }

      #expander-box {
        margin-left: 5px;
        background: none;
      }
    '';
  };
}
