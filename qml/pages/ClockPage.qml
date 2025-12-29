import QtQuick
import QtQuick.Controls

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
        color: "black"

        Column {
            anchors.fill: parent
            spacing: 8

            Text {
                id: dateText
                anchors.bottom: timeText.top
                anchors.left: timeText.left
                font.pixelSize: 40
                font.bold: false
                color: "light gray"
                text: dates
            }

            Text {
                id: timeText
                anchors.centerIn: parent
                font.pixelSize: 120
                font.bold: true
                color: "white"
                text: time
            }
        }

        Timer {
            interval: 1000
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: updateTime()
        }

        Timer {
            interval: 100000
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: updateDate()
        }

        Connections {
            target: timeZoneManager
            function onTimeZoneIdChanged() { updateTime(); updateDate() }
            function onTimeFormatChanged() { updateTime(); updateDate() }
            function onDateFormatChanged() { updateTime(); updateDate() }
        }
    }

    Component.onCompleted: updateTime()
}
