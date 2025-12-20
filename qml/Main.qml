import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.VirtualKeyboard

Window {
    id: window
    width: 1024
    height: 600
    visible: true
    title: qsTr("Welcome")
    color: "black"

    Component.onCompleted: {
        if (appFullscreen) {
            window.showFullScreen()
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "black"

        ToolButton {
            id: settingsButton
            text: "⚙️"
            font.pixelSize: 28
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 12
            anchors.rightMargin: 16
            background: Rectangle {
                radius: 18
                color: "#222222"
                border.color: "#444444"
            }
            onClicked: settingsDrawer.open()
        }

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

    Drawer {
        id: settingsDrawer
        edge: Qt.RightEdge
        width: 320
        height: parent.height
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Rectangle {
            anchors.fill: parent
            color: "#111111"

            Rectangle {
                id: settingsHeader
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 16
                height: 48
                color: "transparent"

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Settings"
                    font.pixelSize: 24
                    color: "white"
                }
            }

            Rectangle {
                anchors.top: settingsHeader.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 16
                height: 1
                color: "#333333"
            }

            ListView {
                id: settingsList
                anchors.top: settingsHeader.bottom
                anchors.topMargin: 24
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 16
                clip: true
                model: ["Display", "Sound", "Notifications", "Wi‑Fi", "Bluetooth", "Date & Time", "Language", "Accessibility", "About", "Developer Options", "Privacy", "Updates"]

                delegate: Rectangle {
                    width: parent.width
                    height: 48
                    color: "transparent"

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData
                        color: "white"
                        font.pixelSize: 18
                    }

                    Rectangle {
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: 1
                        color: "#222222"
                    }
                }
            }
        }
    }
}
