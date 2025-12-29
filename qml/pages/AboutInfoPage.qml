import QtQuick
import QtQuick.Controls
import "../components"

Item {
    id: aboutPage
    property StackView stackView: StackView.view
    width: parent ? parent.width : 0
    height: parent ? parent.height : 0

    Rectangle {
        anchors.fill: parent
        color: "#111111"

        Rectangle {
            id: header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 16
            height: 48
            color: "transparent"

            BackButtonComponent {
                id: backButton
                anchors.verticalCenter: parent.verticalCenter
                stackView: aboutPage.stackView
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: backButton.right
                anchors.leftMargin: 8
                color: "white"
                font.pixelSize: 24
                text: "About"
            }
        }

        Rectangle {
            id: divider
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 16
            height: 1
            color: "#333333"
        }

        Text {
            anchors.left: parent.left
            anchors.top: divider.bottom
            anchors.margins: 16
            color: "white"
            font.pixelSize: 16
            text: qsTr("This application is made by Poseidon. \nThanks for using it!
Do you have any questions about how it \nworks feel free to send a mail to: \nHello@gmail.com")
        }
    }
}
