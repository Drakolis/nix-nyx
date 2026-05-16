import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.modules.common

PanelWindow {
  id: eggshellBar
  anchors {
    top: true
    left: true
    right: true
  }
  implicitHeight: Config.data.computed.bar.segmentHeight + Config.data.theme.margins.outer * 2

  color: "transparent"

  Rectangle {
    anchors.fill: parent
    color: "transparent"
    // left
    RowLayout {
      anchors {
        verticalCenter: parent.verticalCenter
        left: parent.left
        leftMargin: 5
      }
      Workspaces { id: workspaces }
      WindowTitle { id: windowTitle }
    }
    // center
    RowLayout {
      anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
      }

      Time { id: clock }
    }
    // right
    RowLayout {
      anchors {
        verticalCenter: parent.verticalCenter
        right: parent.right
        rightMargin: 5
      }
      Tray { id: systemTray }
      Status { id: systemStatus }
    }
  }
  BackgroundEffect.blurRegion: Region {
    Region {
      item: systemTray
      radius: systemTray.radius
    }
    Region {
      item: systemStatus
      radius: systemStatus.radius
    }
    Region {
      item: clock
      radius: clock.radius
    }
    Region {
      item: windowTitle
      radius: windowTitle.radius
    }
    Region {
      item: workspaces
      radius: workspaces.radius
    }
  }
}
