import QtQuick
import QtQuick.Controls

Button {
    id: root
    property string iconText: ""

    text: iconText
    font.pixelSize: 20
    background: Rectangle {
        radius: 6
        color: "transparent"
        border.color: "#333333"
    }
}
