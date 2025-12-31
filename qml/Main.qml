import QtQuick
import QtQuick.Controls
import "pages"

ApplicationWindow {
    id: window
    width: 800
    height: 480
    visible: true

    Component.onCompleted: {
        if (typeof appFullscreen !== "undefined" && appFullscreen)
            window.showFullScreen()
    }

    // Main screen content
    Loader {
        anchors.fill: parent
        sourceComponent: ClockPage { }
    }

    // Settings button stays in the shell so it overlays pages
    ToolButton {
        id: settingsButton
        text: "S"
        font.pixelSize: 28
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 12
        anchors.rightMargin: 16
        background: Rectangle { color: Styling.bg }
        onClicked: settingsDrawer.open()
    }

    Drawer {
        id: settingsDrawer
        edge: Qt.RightEdge
        width: 360
        height: parent.height
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        contentItem: Item {
            anchors.fill: parent

            StackView {
                id: settingsStack
                anchors.fill: parent
                initialItem: SettingsListPage { }
            }
        }
    }
}

