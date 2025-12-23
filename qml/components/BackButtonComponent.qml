import QtQuick
import QtQuick.Controls

ToolButton {
    property StackView stackView: StackView.view

    text: "<"
    font.pixelSize: 20
    onClicked: {
        const stack = stackView || StackView.view
        if (stack) stack.pop()
    }
}
