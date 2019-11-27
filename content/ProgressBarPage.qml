import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1

Item {
    width: parent.width
    height: parent.height

    property real progress: 0
    SequentialAnimation on progress {
        loops: Animation.Infinite
        running: true
        NumberAnimation {
            from: 0
            to: 1
            duration: 3000
        }
        NumberAnimation {
            from: 1
            to: 0
            duration: 3000
        }
    }

    Column {
        spacing: 40
        anchors.centerIn: parent

        ProgressBar {
            anchors.margins: 20
            style: touchStyle
            width: 400
            value: progress
        }

        ProgressBar {
            anchors.margins: 20
            style: touchStyle
            width: 400
            value: 1 - progress
        }

        ProgressBar {
            anchors.margins: 20
            style: touchStyle
            value: 1
            width: 400
        }

    }

    Component {
        id: touchStyle
        ProgressBarStyle {
            panel: Rectangle {
                implicitHeight: 15
                implicitWidth: 400
                color: "#444"
                opacity: 0.8
                Rectangle {
                    antialiasing: true
                    radius: 1
                    color: "#468bb7"
                    height: parent.height
                    width: parent.width * control.value / control.maximumValue
                }
            }
        }
    }
}
