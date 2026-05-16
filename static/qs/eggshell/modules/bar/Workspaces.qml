import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common
import qs.modules.common.widgets

BarSection {
  Repeater {
    model: niri.workspaces

    Rectangle {
      visible: output === eggshellBar.screen.name
      width: Config.data.computed.bar.iconSize
      height: Config.data.computed.bar.iconSize
      radius: Config.data.computed.bar.iconSize / 2

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
