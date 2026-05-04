import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.modules.common
import qs.modules.common.utils

Rectangle {
  id: workspaceLayout

  color: Config.data.theme.colors.panel
  height: Config.data.theme.fontBar.pixelSize * 2
  radius: Config.data.theme.fontBar.pixelSize * 2
  implicitWidth: childrenRect.width + Config.data.theme.margins.inner * 2

  RowLayout {
    id: workspaceRow
    anchors.centerIn: parent
    spacing: 5

    Repeater {
      model: niri.workspaces

      Rectangle {
        visible: output === eggshellBar.screen.name
        width: Config.data.theme.fontBar.pixelSize * 2 - Config.data.theme.margins.inner
        height: Config.data.theme.fontBar.pixelSize * 2 - Config.data.theme.margins.inner
        radius: Config.data.theme.fontBar.pixelSize * 2

        color: model.isActive ? Config.data.theme.colors.primary : Config.data.theme.colors.panel

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: niri.focusWorkspaceById(model.id)
        }
        Text {
          id: workspaceId
          anchors.centerIn: parent

          text: index

          color: model.isActive ? Config.data.theme.colors.canvas : Config.data.theme.colors.text
          font: Config.data.theme.fontBar
        }
      }
    }
  }

  layer.enabled: true
  layer.effect: MultiEffect {
    shadowEnabled: true
    autoPaddingEnabled: true
    // The vertical offset makes the shadow slightly more prominent
    shadowBlur: 0.5
    shadowColor: Config.data.theme.colors.canvas
  }
}
