import QtQuick
import QtQuick.Controls
import "../components"
import Clock 1.0

Item {
    id: wifiPage
    property StackView stackView: StackView.view
    width: parent ? parent.width : 320
    height: parent ? parent.height : 480

    Rectangle {
        anchors.fill: parent
        color: Styling.setting_bg

        Rectangle {
            id: header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 8
            height: 48
            color: "transparent"

            BackButtonComponent {
                id: backButton
                anchors.verticalCenter: parent.verticalCenter
                stackView: wifiPage.stackView
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: backButton.right
                anchors.leftMargin: 8
                text: "Wi-Fi"
                font.pixelSize: 24
                color: "white"
            }

            ToolButton {
                text: "Refresh"
                font.pixelSize: 16
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Divider { }
    }
}

