import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window
    width: 800
    height: 480
    visible: true
    color: "black"

    Component.onCompleted: {
        if (typeof appFullscreen !== "undefined" && appFullscreen)
            window.showFullScreen()
    }

    // Main screen content
    Loader {
        anchors.fill: parent
        source: Qt.resolvedUrl("pages/ClockPage.qml")
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
        background: Rectangle { color: "#000000" }
        onClicked: settingsDrawer.open()
    }

    Drawer {
        id: settingsDrawer
        edge: Qt.RightEdge
        width: 320
        height: parent.height
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        StackView {
            id: settingsStack
            anchors.fill: parent
            initialItem: Qt.resolvedUrl("pages/SettingsListPage.qml")
        }
    }
}
