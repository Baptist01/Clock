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
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 16
        background: Rectangle { color: Styling.bg }
        onClicked: settingsDrawer.open()

        contentItem: Text {
            id: settingsButtonText
            text: parent.text
            color: Styling.text
            font.pixelSize: Styling.menu_header_text_size
        }
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

