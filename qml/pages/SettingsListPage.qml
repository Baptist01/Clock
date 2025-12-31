import QtQuick
import QtQuick.Controls
import "../components"
import Clock 1.0

Item {
    id: settingsRoot
    property StackView stackView: StackView.view
    width: parent ? parent.width : 0
    height: parent ? parent.height : 0

    Rectangle {
        anchors.fill: parent
        color: Styling.setting_bg

        Rectangle {
            id: header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 16
            height: 48
            color: "transparent"

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "Settings"
                font.pixelSize: Styling.menu_header_text_size
                color: Styling.text
            }
        }

        Divider { }

        ListView {
            id: settingsList
            anchors.top: header.bottom
            anchors.topMargin: 24
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 16
            clip: true

            model: ["Date & Time", "Wi-Fi", "About", "Display", "Sound", "Notifications", "Bluetooth", "Language", "Privacy"]

            delegate: ItemDelegate {
                width: settingsList.width

                contentItem: Text {
                    text: modelData
                    color: Styling.text
                    font.pixelSize: Styling.menu_header_text_size
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                background: Rectangle {
                    color: "transparent"
                }

                onClicked: {
                    const stack = settingsRoot.stackView
                    if (!stack)
                        return

                    switch (modelData) {
                    case "Display":
                        return stack.push(Qt.resolvedUrl("DisplayInfoPage.qml"))
                    case "Sound":
                        return stack.push(Qt.resolvedUrl("SoundInfoPage.qml"))
                    case "Notifications":
                        return stack.push(Qt.resolvedUrl(
                                              "NotificationsInfoPage.qml"))
                    case "Wi-Fi":
                        return stack.push(Qt.resolvedUrl("WifiInfoPage.qml"))
                    case "Bluetooth":
                        return stack.push(Qt.resolvedUrl(
                                              "BluetoothInfoPage.qml"))
                    case "Date & Time":
                        return stack.push(Qt.resolvedUrl(
                                              "DateTimeInfoPage.qml"))
                    case "Language":
                        return stack.push(Qt.resolvedUrl(
                                              "LanguageInfoPage.qml"))
                    case "About":
                        return stack.push(Qt.resolvedUrl("AboutInfoPage.qml"))
                    case "Privacy":
                        return stack.push(Qt.resolvedUrl("PrivacyInfoPage.qml"))
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
