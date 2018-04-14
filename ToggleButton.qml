import QtQuick 2.0

InteractiveArea {
    property bool checked: false
    property alias text: text1.text

    id: interactiveArea
    width: 80
    height: 40

    states: [
        State {
            name: "press"
            PropertyChanges {
                target: text1
                scale: 0.9
                color: "grey"
            }
        },
        State {
            name: "release"
            PropertyChanges {
                target: text1
                scale: 1.0
                color: "dimgrey"
            }
        },
        State {
            name: "hover"
            PropertyChanges {
                target: text1
                scale: 1.1
                color: "dimgrey"
            }
        },
        State {
            name: "exited"
            PropertyChanges {
                target: text1
                scale: 1
                color: "black"
            }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation{
                properties: "scale"
                duration: 30
            }

            ColorAnimation {
                properties: "color"
                duration: 30
            }
        }
    ]


    onPressed: {
        state = "press"
    }

    onReleased: {
        state = "release"
        checked = true
        parent.change(this)
    }

    onEntered: {
        state = "hover"
    }

    onExited: {
        state = "exited"
    }

    Text {
        id: text1
        height: 30
        text: qsTr("Text")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        elide: Text.ElideMiddle
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Segoe UI Symbol"
        font.pixelSize: 18
    }

    Rectangle {
        id: rectangle
        width: text1.width
        height: 3
        color: "#07439d"
        radius: 2
        anchors.horizontalCenter: parent.horizontalCenter
        visible: checked
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }

}
