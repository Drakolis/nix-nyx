import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.modules.common
import qs.modules.common.utils

Rectangle {
    color: Config.data.theme.colors.panel
    height: Config.data.theme.fontBar.pixelSize * 2
    radius: Config.data.theme.fontBar.pixelSize * 2
    implicitWidth: childrenRect.width + Config.data.theme.fontBar.pixelSize * 1.75

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
    Text {
        id: timeBlock
        anchors.centerIn: parent

        text: Qt.formatDateTime(clock.date, "hh:mm:ss, ddd dd MMMM")

        color: Config.data.theme.colors.clock
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
