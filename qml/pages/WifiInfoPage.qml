import QtQuick
import QtQuick.Controls
import "../components"

Item {
    id: wifiPage
    property StackView stackView: StackView.view
    width: parent ? parent.width : 320
    height: parent ? parent.height : 480

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

            BackButtonComponent {
                anchors.verticalCenter: parent.verticalCenter
                stackView: wifiPage.stackView
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

        // Example list using the backend exposed in main.cpp.
        ListView {
            anchors.top: wifiHeader.bottom
            anchors.topMargin: 24
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 16
            clip: true

            model: connmanServices.wifiModel

            delegate: ItemDelegate {
                width: ListView.view.width
                contentItem: Text {
                    text: name + "  [" + state + "]"
                    color: "white"
                    font.pixelSize: 18
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                background: Rectangle { color: "transparent" }
                onClicked: console.log("Selected:", name, path)
            }
        }
    }
}

