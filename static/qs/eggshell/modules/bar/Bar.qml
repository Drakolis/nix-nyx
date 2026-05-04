import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common

PanelWindow {
  id: eggshellBar
  anchors {
    top: true
    left: true
    right: true
  }
  implicitHeight: Config.data.theme.fontBar.pixelSize * 2
  + Config.data.theme.margins.outer * 2
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
      Loader { active: true; sourceComponent: Workspaces {} }
      Loader { active: true; sourceComponent: WindowTitle {} }
    }
    // center
    RowLayout {
      anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
      }

      Loader { active: true; sourceComponent: Time {} }
    }
    // right
    RowLayout {
      anchors {
        verticalCenter: parent.verticalCenter
        right: parent.right
        rightMargin: 5
      }
      spacing: 10
      Loader { active: true; sourceComponent: Power {} }
    }
  }
}
