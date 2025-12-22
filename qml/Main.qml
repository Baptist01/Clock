import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.VirtualKeyboard

Window {
    id: window
    width: 800
    height: 480
    visible: true
    title: qsTr("Welcome")
    color: "black"

    ToolButton {
        id: settingsButton
        text: "⚙"
        font.pixelSize: 28
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 12
        anchors.rightMargin: 16
        background: Rectangle {
            color: "#000000"
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
        id: clockTimer
        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: timeText.text = Qt.formatTime(new Date(), "hh:mm:ss")
    }

    Drawer {
        id: settingsDrawer
        edge: Qt.RightEdge
        width: 320
        height: parent.height
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        StackView {
            id: settingsStack
            anchors.fill: parent
            initialItem: settingsListPage
        }
    }

    Component {
        id: settingsListPage

        Item {
            width: settingsStack.width
            height: settingsStack.height

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
                    delegate: ItemDelegate {
                        width: parent.width
                        text: modelData
                        font.pixelSize: 18
                        contentItem: Text {
                            text: modelData
                            color: "white"
                            font.pixelSize: 18
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }
                        background: Rectangle {
                            color: "transparent"
                        }
                        onClicked: {
                            if (modelData === "Wi‑Fi") {
                                settingsStack.push(wifiPage)
                            }
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

    Component {
        id: wifiPage

        Item {
            width: settingsStack.width
            height: settingsStack.height

            Rectangle {
                anchors.fill: parent
                color: "#111111"

                Rectangle {
                    id: wifiHeader
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 16
                    height: 48
                    color: "transparent"

                    ToolButton {
                        text: "←"
                        font.pixelSize: 20
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: settingsStack.pop()
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 36
                        text: "Wi-Fi"
                        font.pixelSize: 24
                        color: "white"
                    }

                    ToolButton {
                        text: "Refresh"
                        font.pixelSize: 16
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: connmanServices.refresh()
                    }
                }

                Rectangle {
                    anchors.top: wifiHeader.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 16
                    height: 1
                    color: "#333333"
                }

                Text {
                    id: wifiUnavailableText
                    anchors.top: wifiHeader.bottom
                    anchors.topMargin: 24
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 16
                    text: "ConnMan is not available."
                    color: "#888888"
                    font.pixelSize: 16
                    visible: !connmanServices.available
                }

                ListView {
                    id: wifiList
                    anchors.top: wifiHeader.bottom
                    anchors.topMargin: 24
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 16
                    clip: true
                    visible: connmanServices.available
                    model: connmanServices
                    delegate: ItemDelegate {
                        width: ListView.view ? ListView.view.width : 0
                        text: name
                        font.pixelSize: 18
                        contentItem: Text {
                            text: name + (state.length ? ("  [" + state + "]") : "")
                            color: "white"
                            font.pixelSize: 18
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }
                        background: Rectangle {
                            color: "transparent"
                        }
                        onClicked: {
                            console.log("Selected Wi-Fi network:", name)
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
}
