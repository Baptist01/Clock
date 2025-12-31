import QtQuick
import QtQuick.Controls
import Clock 1.0

MouseArea {
    property StackView stackView: StackView.view

    width: 40
    height: 40

    Rectangle {
        anchors.fill: parent
        radius: 20
        color: pressed ? Styling.pressed_btn : Styling.unpressed_btn

        Text {
            id: backtext
            anchors.centerIn: parent
            font.pixelSize: 25
            text: qsTr("<")
            color: "white"
        }
    }

    onClicked: {
        const stack = stackView || StackView.view
        if (stack) stack.pop()
    }
}
