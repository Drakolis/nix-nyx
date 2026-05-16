import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import qs.modules.common
import qs.modules.common.utils
import qs.modules.common.widgets

BarSection {
  spacing: Config.data.theme.margins.inner

  Repeater {
    model: SystemTray.items.values

    RowLayout {
      id: trayItem
      spacing: Config.data.theme.margins.icon

      MouseArea {
        Layout.fillHeight: true
        Layout.fillWidth: true
        cursorShape: Qt.PointingHandCursor
        onClicked: event => {
          if (event.button === Qt.LeftButton) {
            modelData.activate();
          } else {
            modelData.secondaryActivate();
          }
        }
      }

      // TrayIcon {
      //   applicationId: modelData.id
      //   icon: modelData.icon
      // }

      Image {
        source: modelData.icon
        sourceSize.width: Config.data.computed.bar.iconSize
        sourceSize.height: Config.data.computed.bar.iconSize
      }

    }
  }
}
