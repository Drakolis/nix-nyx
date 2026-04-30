import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.modules.common
import qs.modules.common.utils

Rectangle {
    color: Config.data.theme.colors.panel
    height: Config.data.theme.fontBar.pixelSize * 2
    radius: Config.data.theme.fontBar.pixelSize * 2
    implicitWidth: childrenRect.width + Config.data.theme.fontBar.pixelSize * 1.75

    // IconImage {
    //     anchors {
    //         verticalCenter: parent.verticalCenter
    //         left: parent.left
    //         leftMargin: Config.data.theme.margins.inner
    //     }
    //     source: DesktopEntries.byId(niri.focusedWindow?.appId)?.icon ?? "show-desktop"
    // }
    Text {
        anchors.centerIn: parent
        text: niri.focusedWindow?.title ?? "Desktop"

        color: Config.data.theme.colors.primary
        font: Config.data.theme.fontBar
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
