import QtQuick
import QtQuick.Controls
import Clock 1.0

Item {
    property string time: ""
    property string dates: ""

    function updateTime() {
        time = timeZoneManager.formattedTime(timeZoneManager.timeFormat)
    }

    function updateDate() {
        dates = timeZoneManager.formattedDate(timeZoneManager.dateFormat)
    }

    Rectangle {
        anchors.fill: parent
        color: Styling.bg

        Text {
            id: dateText
            anchors.bottom: timeText.top
            anchors.left: timeText.left
            font.pixelSize: Styling.date_text_size
            font.bold: false
            color: Styling.text
            text: dates
        }

        Text {
            id: timeText
            anchors.centerIn: parent
            font.pixelSize: Styling.time_text_size
            font.bold: true
            color: Styling.text
            text: time
        }

        Timer {
            interval: 1000
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: updateTime()
        }

        Timer {
            interval: 1000
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: updateDate()
        }

        Connections {
            target: timeZoneManager
            function onTimeZoneIdChanged() {
                updateTime()
                updateDate()
            }
            function onTimeFormatChanged() {
                updateTime()
                updateDate()
            }
            function onDateFormatChanged() {
                updateTime()
                updateDate()
            }
        }
    }

    Component.onCompleted: updateTime()
}
