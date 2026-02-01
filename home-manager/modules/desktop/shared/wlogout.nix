let
  style = import ../../../../shared/constants/style.nix;
in
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    style = ''
        * {
      	background-image: none;
      	box-shadow: none;
      }

      window {
      	background-color: alpha(#${style.colors.shadow}, ${toString style.opacity.screen.decimal});
      }

      button {
      	border-radius: 0;
      	border-color: #${style.colors.primary};
      	text-decoration-color: #${style.colors.text};
      	color: #${style.colors.text};
      	background-color: #${style.colors.panel};
      	border-style: solid;
      	border-width: 1px;
      	background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;
      }

      button:focus, button:active, button:hover {
      	/* 20% Overlay 2, 80% mantle */
      	background-color: rgb(48, 50, 66);
      	outline-style: none;
      }

      #lock {
        background-image: url("/home/drakolis/.config/wlogout/icons/lock.svg");
      }

      #logout {
        background-image: url("/home/drakolis/.config/wlogout/icons/logout.svg");
      }

      #suspend {
        background-image: url("/home/drakolis/.config/wlogout/icons/suspend.svg");
      }

      #hibernate {
        background-image: url("/home/drakolis/.config/wlogout/icons/hibernate.svg");
      }

      #shutdown {
        background-image: url("/home/drakolis/.config/wlogout/icons/shutdown.svg");
      }

      #reboot {
        background-image: url("/home/drakolis/.config/wlogout/icons/reboot.svg");
      }
    '';
  };
  home.file = {
    ".config/wlogout/icons/" = {
      source = ./files/wlogout;
      recursive = true;
    };
  };
}
