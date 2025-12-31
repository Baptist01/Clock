pragma Singleton
import QtQuick 2.15

QtObject {
    // colors
    property color bg: "#000"
    property color setting_bg: "#111"
    property color text: "lightgrey"
    readonly property color pressed_btn: "#444"
    readonly property color unpressed_btn: "#222"

    // text
    property int date_text_size: 50
    property int time_text_size: 140
    property int menu_header_text_size: 48
    property int menu_text_size: 30
    property int menu_small_text_size: 18

    // margins
    readonly property int combox_height: 30
    readonly property int spacing: 10
}
