pragma Singleton
import QtQuick

QtObject {
  enum Orientation {
    Horizontal,
    Vertical
  }
  //
  // enum Position {
  //   Top,
  //   Bottom
  // }
  //
  // enum Network {
  //   Wired,
  //   Wireless,
  //   Virtual
  // }

  enum BatteryStatus {
    Charging,
    Discharging,
    Full,
    Unknown
  }

  enum IconSize {
    Small,
    Medium,
    Large
  }

  function iconSizeToPixels(size) {
    switch (size) {
      case Types.IconSize.Small:
      return 24;
      case Types.IconSize.Medium:
      return 32;
      case Types.IconSize.Large:
      return 64;
      default:
      console.error("Error: invalid IconSize value:", size)
      return 24;
    }
  }

  function stringToOrientation(str) {
    const normalized = str.toLowerCase();
    switch (normalized) {
      case "horizontal":
      return Types.Orientation.Horizontal;
      case "vertical":
      return Types.Orientation.Vertical;
      default:
      console.error("Error: invalid Orientation value:", str)
      return -1;
    }
  }

  function orientationToString(value) {
    switch (value) {
      case Types.Orientation.Horizontal:
      return "horizontal"
      case Types.Orientation.Vertical:
      return "vertical"
      default:
      console.error("Error: invalid Orientation value:", value)
      return "";
    }
  }

  function orientationIconName(value) {
    switch (value) {
      case Types.Orientation.Horizontal:
      return "horizontal"
      case Types.Orientation.Vertical:
      return "vertical"
      default:
      console.error("Error: invalid Orientation value:", value)
      return "";
    }
  }

  // function stringToPosition(str) {
  //   const normalized = str.toLowerCase();
  //   switch (normalized) {
  //     case "top":
  //     return Types.Position.Top;
  //     case "bottom":
  //     return Types.Position.Bottom;
  //     default:
  //     console.error("Error: invalid Position value:", str)
  //     return -1;
  //   }
  // }
  //
  // function positionToString(value) {
  //   switch (value) {
  //     case Types.Position.Top:
  //     return "top"
  //     case Types.Position.Bottom:
  //     return "bottom"
  //     default:
  //     console.error("Error: invalid Position value:", value)
  //     return "";
  //   }
  // }
  //
  // function stringToNetwork(str) {
  //   const normalized = str.toLowerCase();
  //   switch (normalized) {
  //     case "wired":
  //     return Types.Network.Wired;
  //     case "wireless":
  //     return Types.Network.Wireless;
  //     case "virtual":
  //     return Types.Network.Virtual;
  //     default:
  //     console.error("Error: invalid Network value:", str)
  //     return -1;
  //   }
  // }
  //
  // function networkToString(value) {
  //   switch (value) {
  //     case Types.Network.Wired:
  //     return "wired"
  //     case Types.Network.Wireless:
  //     return "wireless"
  //     case Types.Network.Virtual:
  //     return "virtual";
  //     default:
  //     console.error("Error: invalid Network value:", value)
  //     return "";
  //   }
  // }
}
