import QtQuick
import QtQuick.Controls

Item {
    id: pageRoot
    property StackView stackView: StackView.view
    anchors.fill: parent

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

            ToolButton {
                text: "<"
                font.pixelSize: 20
                anchors.verticalCenter: parent.verticalCenter
                onClicked: pageRoot.stackView && pageRoot.stackView.pop()
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 36
                color: "white"
                font.pixelSize: 24
                text: "Privacy"
            }
        }

        Rectangle {
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 16
            height: 1
            color: "#333333"
        }

        Text {
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 20
            text: "Privacy settings (coming soon)"
        }
    }
}

