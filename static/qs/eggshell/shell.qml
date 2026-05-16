import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Niri 0.1
import "./modules/bar/"
import "./modules/common/"

ShellRoot{
  id: root

  Niri {
    id: niri
    Component.onCompleted: connect()

    onConnected: console.info("Connected to niri")
    onErrorOccurred: function(error) {
      console.error("Niri error:", error)
    }
  }

  FontLoader {
    id: tablerIconsFont
    source: Qt.resolvedUrl(Quickshell.shellPath("assets/fonts/tabler-icons.ttf"))
  }

  Variants {
    // see Variants for details
    model: Quickshell.screens

    LazyLoader {
      property var modelData
      active: true
      component: Bar {
        screen: modelData
      }
    }
  }
}
