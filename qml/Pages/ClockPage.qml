import QtQuick
import QtQuick.Controls

Item {
    Rectangle {
        anchors.fill: parent
        color: "black"

        Text {
            id: timeText
            anchors.centerIn: parent
            font.pixelSize: 120
            font.bold: true
            color: "white"
            text: Qt.formatTime(new Date(), "hh:mm:ss")
        }

        Timer {
            interval: 1000
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: timeText.text = Qt.formatTime(new Date(), "hh:mm:ss")
        }
    }
}
