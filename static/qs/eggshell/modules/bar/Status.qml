import QtQuick
import qs.modules.bar.status
import qs.modules.common
import qs.modules.common.widgets

BarSection {
  spacing: Config.data.theme.margins.inner

  AudioOut {}
  AudioIn {}
  Monitor {}
  Camera {}
  Battery {}
  Bluetooth {}
  Network {}
  // CPU {}
  // GPU {}
  // RAM {}
}
