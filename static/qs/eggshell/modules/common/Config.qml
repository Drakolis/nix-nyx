pragma Singleton
import Quickshell
import Quickshell.Io
import qs.modules.common

Singleton {
  property var data: adapter

  FileView {
    path: Quickshell.shellPath("config.json")
    watchChanges: true
    onFileChanged: reload()
    onAdapterUpdated: writeAdapter()
    blockLoading: true
    // For some reason, this is needed to read workspaces.maxCount from the
    // config.json.
    preload: false

    JsonAdapter {
      id: adapter

      // Global theme. Source of default and base values for all components.
      property JsonObject theme: JsonObject {
        property JsonObject colors: JsonObject {
          property string rosewater: "#f5e0dc"
          property string flamingo: "#f2cdcd"
          property string pink: "#f5c2e7"
          property string mauve: "#cba6f7"
          property string red: "#f38ba8"
          property string maroon: "#eba0ac"
          property string peach: "#fab387"
          property string yellow: "#f9e2af"
          property string green: "#a6e3a1"
          property string teal: "#94e2d5"
          property string sky: "#89dceb"
          property string sapphire: "#74c7ec"
          property string blue: "#89b4fa"
          property string lavender: "#b4befe"
          property string text: "#cdd6f4"
          property string subtext1: "#bac2de"
          property string subtext0: "#a6adc8"
          property string overlay2: "#9399b2"
          property string overlay1: "#7f849c"
          property string overlay0: "#6c7086"
          property string surface2: "#585b70"
          property string surface1: "#45475a"
          property string surface0: "#313244"
          property string base: "#1e1e2e"
          property string mantle: "#181825"
          property string crust: "#11111b"

          property string border: Config.data.theme.colors.surface0
          property string window: Config.data.theme.colors.base
          property string panel: Config.data.theme.colors.mantle
          property string canvas: Config.data.theme.colors.crust
          property string primary: Config.data.theme.colors.mauve
          property string secondary: Config.data.theme.colors.lavender
          property string success: Config.data.theme.colors.green
          property string error: Config.data.theme.colors.red
          property string warning: Config.data.theme.colors.peach
          property string info: Config.data.theme.colors.teal

          property string textDisabled: Config.data.theme.colors.subtext0

          property string clock: Config.data.theme.colors.sapphire
          property string audio: Config.data.theme.colors.flamingo
          property string brightness: Config.data.theme.colors.yellow
          property string camera: Config.data.theme.colors.rosewater
          property string bluetooth: Config.data.theme.colors.blue
          property string network: Config.data.theme.colors.lavender
        }

        property JsonObject fontBar: JsonObject {
          property string family: "Sans"
          property real pixelSize: 16
          property real weight: 900
        }

        // Proportional font
        property JsonObject font: JsonObject {
          property string family: "Sans"
          // Size in pixels of all proportional fonts. The actual size
          // of fonts in individual components will be proportional to
          // this value.
          property real pixelSize: 14
        }
        // Monospace font
        property JsonObject fontMono: JsonObject {
          property string family: "Monospace"
          // Size in pixels of all monospace fonts. The actual size of
          // fonts in individual components will be proportional to
          // this value.
          property real pixelSize: 14
        }
        property JsonObject widget: JsonObject {
          // Size in pixels of all widgets. The actual size of
          // individual widgets will be proportial to this value.
          property real size: 24
        }
        property JsonObject margins: JsonObject {
          property real outer: 5
          property real inner: 7
          property real icon: 3
        }
      }

      property JsonObject computed: JsonObject {
        property JsonObject bar: JsonObject {
          property real segmentHeight: Config.data.theme.fontBar.pixelSize * 2
          property real segmentRadius: Config.data.theme.fontBar.pixelSize
          property real segmentSpacing: Config.data.theme.margins.inner
          property real iconSize: Config.data.theme.fontBar.pixelSize * 1.95 - Config.data.theme.margins.inner
        }
      }

      // Defines the widgets that should be shown in each section and their order.
      property JsonObject layout: JsonObject {
        property JsonObject left: JsonObject {
          property list<string> widgets: ["workspaces", "focusedWindow"]
          property bool separator: true
          property int spacing: 6
        }
        property JsonObject center: JsonObject {
          property list<string> widgets: []
          property bool separator: true
          property int spacing: 6
        }
        property JsonObject right: JsonObject {
          property list<string> widgets: ["cpu", "ram", "network", "battery", "clock"]
          property bool separator: true
          property int spacing: 6
        }
      }

      property JsonObject bar: JsonObject {
      }

      property JsonObject windowTitle: JsonObject {
        property JsonObject icon: JsonObject {
          property bool enabled: true
        }
        property JsonObject title: JsonObject {
          property bool enabled: true
          property int maxLength: 30
        }
      }

      property JsonObject clock: JsonObject {
        property string format: "hh:mm:ss, ddd dd MMMM"
      }

      property JsonObject battery: JsonObject {
        property bool enabled: true
        property bool showAlways: false
        property bool showPercentage: true
        property real warning: 0.20
        property real critical: 0.10
        property string orientation: Types.orientationToString(Types.Orientation.Horizontal)
      }

      property JsonObject audio: JsonObject {
        property bool enabled: true
        property bool showPercentage: true
        property bool showMicrophone: true
        property bool showMicrophonePercentage: true
        property string microphonePrivacyColor: Config.data.theme.colors.info
      }

      property JsonObject camera: JsonObject {
        property bool enabled: true
        property string privacyColor: Config.data.theme.colors.info
        property int pollPrivacyInterval: 1000
        property int pollDeviceInterval: 5000
      }

      property JsonObject monitor: JsonObject {
        property bool enabled: true
        property string privacyColor: Config.data.theme.colors.info
        property int pollPrivacyInterval: 1000
      }

      property JsonObject bluetooth: JsonObject {
        property bool enabled: true
      }

      property JsonObject cpu: JsonObject {
        property real scale: 1
        property real updateInterval: 1000  // Milliseconds
        property int numTopProcesses: 5
        property JsonObject icon: JsonObject {
          property bool enabled: true
          property real scale: 0.85
          property string color: Config.data.theme.colors.text
        }
        property JsonObject graph: JsonObject {
          property bool enabled: true
          property real history: 30 // Seconds
          property string lineColor: Config.data.theme.colors.text
          property string lowUsageColor: "#802D3154"   // Cool blue
          property string highUsageColor: "#80FF4500"  // Bright orange/red
        }
      }

      property JsonObject ram: JsonObject {
        property real scale: 1
        property real updateInterval: 1000  // Milliseconds
        property string sizeUnit: "GiB"
        property int numTopProcesses: 5
        property JsonObject icon: JsonObject {
          property bool enabled: true
          property real scale: 1
          property string color: Config.data.theme.colors.text
        }
        property JsonObject colors: JsonObject {
          property string used: "#2E86C1"           // Blue
          property string shared: "#004880"         // Dark blue
          property string buffersCached: "#7D3C98"  // Purple
          property string free: "#666666"           // Gray
        }
        property JsonObject graph: JsonObject {
          property bool enabled: true
        }
      }

      property JsonObject network: JsonObject {
        property bool enabled: true
        property bool showPercentage: true
      }

      property JsonObject workspaces: JsonObject {
        property int maxCount: 10
        property JsonObject icon: JsonObject {
          property real scale: 0.6
          property real radius: 1
        }
        property JsonObject colors: JsonObject {
          property string active: "#000000"
          property string inactive: "#333333"
        }
      }
    }
  }
}
