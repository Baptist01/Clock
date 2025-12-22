import QtQuick
import QtQuick.Controls

Item {
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

            ToolButton {
                text: "←"
                font.pixelSize: 20
                anchors.verticalCenter: parent.verticalCenter
                onClicked: StackView.view.pop()
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

                // Your backend object name might be different.
                // If you used my C++ example, it's `connman.refresh()` not `connmanServices.refresh()`.
                onClicked: connman.refresh()
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

        // Example list using my earlier backend: connman.wifiModel
        ListView {
            anchors.top: wifiHeader.bottom
            anchors.topMargin: 24
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 16
            clip: true

            model: connman.wifiModel

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

