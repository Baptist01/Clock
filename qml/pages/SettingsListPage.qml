import QtQuick
import QtQuick.Controls

Item {
    id: settingsRoot
    property StackView stackView: StackView.view
    width: parent ? parent.width : 0
    height: parent ? parent.height : 0

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

            model: ["Date & Time","Wi-Fi","About",
                    "Display","Sound","Notifications","Bluetooth",
                    "Language","Privacy"]

            delegate: ItemDelegate {
                width: settingsList.width

                contentItem: Text {
                    text: modelData
                    color: "white"
                    font.pixelSize: 22
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                background: Rectangle { color: "transparent" }

                onClicked: {
                    const stack = settingsRoot.stackView
                    if (!stack) return

                    switch (modelData) {
                    case "Display": return stack.push(Qt.resolvedUrl("DisplayInfoPage.qml"))
                    case "Sound": return stack.push(Qt.resolvedUrl("SoundInfoPage.qml"))
                    case "Notifications": return stack.push(Qt.resolvedUrl("NotificationsInfoPage.qml"))
                    case "Wi-Fi": return stack.push(Qt.resolvedUrl("WifiInfoPage.qml"))
                    case "Bluetooth": return stack.push(Qt.resolvedUrl("BluetoothInfoPage.qml"))
                    case "Date & Time": return stack.push(Qt.resolvedUrl("DateTimeInfoPage.qml"))
                    case "Language": return stack.push(Qt.resolvedUrl("LanguageInfoPage.qml"))
                    case "About": return stack.push(Qt.resolvedUrl("AboutInfoPage.qml"))
                    case "Privacy": return stack.push(Qt.resolvedUrl("PrivacyInfoPage.qml"))
                    case "Updates": return stack.push(Qt.resolvedUrl("UpdatesInfoPage.qml"))
                    case "Developer Options": return stack.push(Qt.resolvedUrl("DeveloperOptionsPage.qml"))
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
