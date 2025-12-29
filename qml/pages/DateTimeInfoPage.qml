import QtQuick
import QtQuick.Controls
import "../components"

Item {
    id: dateTimePage
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
                stackView: dateTimePage.stackView
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: backButton.right
                anchors.leftMargin: 8
                color: "white"
                font.pixelSize: 24
                text: "Date & Time"
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

        Column {
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 16
            spacing: 16

            Text {
                color: "white"
                font.pixelSize: 20
                text: "Time format"
            }

            ComboBox {
                id: timeFormatCombo
                width: parent.width
                model: timeZoneManager.availableTimeFormats
                onActivated: timeZoneManager.timeFormat = currentText

                Component.onCompleted: {
                    const idx = timeZoneManager.availableTimeFormats.indexOf(timeZoneManager.timeFormat)
                    if (idx >= 0) {
                        currentIndex = idx
                    }
                }
            }

            Text {
                color: "#aaaaaa"
                font.pixelSize: 14
                text: "Preview: " + timeZoneManager.formattedTime(timeZoneManager.timeFormat)
            }

            Text {
                color: "white"
                font.pixelSize: 20
                text: "Date format"
            }

            ComboBox {
                id: dateFormatCombo
                width: parent.width
                model: timeZoneManager.availableDateFormats
                onActivated: timeZoneManager.dateFormat = currentText

                Component.onCompleted: {
                    const idx = timeZoneManager.availableDateFormats.indexOf(timeZoneManager.dateFormat)
                    if (idx >= 0) {
                        currentIndex = idx
                    }
                }
            }

            Text {
                color: "#aaaaaa"
                font.pixelSize: 14
                text: "Preview: " + timeZoneManager.formattedDate(timeZoneManager.dateFormat)
            }

            Text {
                color: "white"
                font.pixelSize: 20
                text: "Time zone"
            }

            ComboBox {
                id: timeZoneCombo
                width: parent.width
                model: timeZoneManager.availableTimeZones
                onActivated: timeZoneManager.timeZoneId = currentText

                Component.onCompleted: {
                    const idx = timeZoneManager.availableTimeZones.indexOf(timeZoneManager.timeZoneId)
                    if (idx >= 0) {
                        currentIndex = idx
                    }
                }
            }

            Text {
                color: "#aaaaaa"
                font.pixelSize: 14
                text: "Current: " + timeZoneManager.timeZoneId
            }

            Connections {
                target: timeZoneManager
                function onTimeZoneIdChanged() {
                    const idx = timeZoneManager.availableTimeZones.indexOf(timeZoneManager.timeZoneId)
                    if (idx >= 0 && timeZoneCombo.currentIndex !== idx) {
                        timeZoneCombo.currentIndex = idx
                    }
                }

                function onTimeFormatChanged() {
                    const idx = timeZoneManager.availableTimeFormats.indexOf(timeZoneManager.timeFormat)
                    if (idx >= 0 && timeFormatCombo.currentIndex !== idx) {
                        timeFormatCombo.currentIndex = idx
                    }
                }
            }
        }
    }
}
