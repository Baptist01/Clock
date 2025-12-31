import QtQuick
import QtQuick.Controls
import "../components"
import Clock 1.0

Item {
    id: dateTimePage
    property StackView stackView: StackView.view
    width: parent ? parent.width : 0
    height: parent ? parent.height : 0

    Rectangle {
        anchors.fill: parent
        color: Styling.setting_bg

        Rectangle {
            id: header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 8
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
                anchors.leftMargin: 16
                color: Styling.text
                font.pixelSize: Styling.menu_header_text_size
                text: "Date & Time"
            }
        }

        Divider {}

        Column {
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 16
            spacing: Styling.spacing

            Text {
                color: "white"
                font.pixelSize: Styling.menu_text_size
                text: "Time format"
            }

            ComboBox {
                id: timeFormatCombo
                width: parent.width
                model: timeZoneManager.availableTimeFormats
                onActivated: timeZoneManager.timeFormat = currentText

                font.pixelSize: Styling.menu_text_size
                height: Styling.combox_height

                Component.onCompleted: {
                    const idx = timeZoneManager.availableTimeFormats.indexOf(
                                  timeZoneManager.timeFormat)
                    if (idx >= 0) {
                        currentIndex = idx
                    }
                }
            }

            Text {
                color: Styling.text
                font.pixelSize: Styling.menu_small_text_size
                text: "Preview: " + timeZoneManager.formattedTime(
                          timeZoneManager.timeFormat)
            }

            Text {
                color: Styling.text
                font.pixelSize: Styling.menu_text_size
                text: "Date format"
            }

            ComboBox {
                id: dateFormatCombo
                width: parent.width
                model: timeZoneManager.availableDateFormats
                onActivated: timeZoneManager.dateFormat = currentText

                font.pixelSize: Styling.menu_text_size
                height: Styling.combox_height

                Component.onCompleted: {
                    const idx = timeZoneManager.availableDateFormats.indexOf(
                                  timeZoneManager.dateFormat)
                    if (idx >= 0) {
                        currentIndex = idx
                    }
                }
            }

            Text {
                color: Styling.text
                font.pixelSize: Styling.menu_small_text_size
                text: "Preview: " + timeZoneManager.formattedDate(
                          timeZoneManager.dateFormat)
            }

            Text {
                color: Styling.text
                font.pixelSize: Styling.menu_text_size
                text: "Time zone"
            }

            ComboBox {
                id: timeZoneCombo
                width: parent.width
                model: timeZoneManager.availableTimeZones
                onActivated: timeZoneManager.timeZoneId = currentText

                font.pixelSize: Styling.menu_text_size
                height: Styling.combox_height

                Component.onCompleted: {
                    const idx = timeZoneManager.availableTimeZones.indexOf(
                                  timeZoneManager.timeZoneId)
                    if (idx >= 0) {
                        currentIndex = idx
                    }
                }
            }

            Text {
                color: Styling.text
                font.pixelSize: Styling.menu_small_text_size
                text: "Current: " + timeZoneManager.timeZoneId
            }

            Connections {
                target: timeZoneManager
                function onTimeZoneIdChanged() {
                    const idx = timeZoneManager.availableTimeZones.indexOf(
                                  timeZoneManager.timeZoneId)
                    if (idx >= 0 && timeZoneCombo.currentIndex !== idx) {
                        timeZoneCombo.currentIndex = idx
                    }
                }

                function onTimeFormatChanged() {
                    const idx = timeZoneManager.availableTimeFormats.indexOf(
                                  timeZoneManager.timeFormat)
                    if (idx >= 0 && timeFormatCombo.currentIndex !== idx) {
                        timeFormatCombo.currentIndex = idx
                    }
                }

                function onDateFormatChanged() {
                    const idx = timeZoneManager.availableDateFormats.indexOf(
                                  timeZoneManager.DateFormat)
                    if (idx >= 0 && timeFormatCombo.currentIndex !== idx) {
                        timeFormatCombo.currentIndex = idx
                    }
                }
            }
        }
    }
}
