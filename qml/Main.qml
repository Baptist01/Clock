import QtQuick
import QtQuick.Window
import QtQuick.VirtualKeyboard

Window {
    id: window
    width: 1024
    height: 600
    visible: true
    title: qsTr("Welcome")
    color: "black"

    Component.onCompleted: {
        console.log("appFullscreen =", appFullscreen)
        if (appFullscreen) {
            window.showFullScreen()
        }
    }

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
            running: true
            repeat: true
            onTriggered: {
                timeText.text = Qt.formatTime(new Date(), "hh:mm:ss")
            }
        }
    }
}

