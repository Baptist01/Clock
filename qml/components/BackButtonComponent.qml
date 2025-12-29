import QtQuick
import QtQuick.Controls

MouseArea {
    property StackView stackView: StackView.view

    width: 40
    height: 40

    // anchors.right: parent.right
    // anchors.rightMargin: 32
    // anchors.verticalCenter: parent.verticalCenter

    Rectangle {
        anchors.fill: parent
        radius: 20
        color: pressed ? "#444" : "#222"

        Text {
            id: backtext
            anchors.centerIn: parent
            text: qsTr("Back")
            color: "white"
        }
    }

    onClicked: {
        const stack = stackView || StackView.view
        if (stack) stack.pop()
    }
}
