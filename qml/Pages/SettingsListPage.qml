import QtQuick
import QtQuick.Controls

Item {
    width: parent ? parent.width : 320
    height: parent ? parent.height : 480
    anchors.fill: parent

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

            model: ["Display","Sound","Notifications","Wi-Fi","Bluetooth","Date & Time","Language",
                    "Accessibility","About","Developer Options","Privacy","Updates"]

            delegate: ItemDelegate {
                width: settingsList.width

                contentItem: Text {
                    text: modelData
                    color: "white"
                    font.pixelSize: 18
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                background: Rectangle { color: "transparent" }

                onClicked: {
                    // StackView is the parent of this page at runtime
                    const stack = StackView.view
                    if (!stack) return

                    if (modelData === "Wi-Fi") {
                        stack.push(Qt.resolvedUrl("WifiPage.qml"))
                    } else {
                        // placeholder page push if you want:
                        // stack.push(Qt.resolvedUrl("PlaceholderPage.qml"), { title: modelData })
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
