import QtQuick 2.0

InteractiveArea {
    property alias imageSource: image.source
    property alias bgColor: background.color

    width: 70
    height: 70

    hoverColor: "#80144f78"
    radius: 35
    clip: false

    states: [
        State {
            name: "mouseEnter"
            PropertyChanges {
                target: content
                scale: 1.2
            }
        },
        State {
            name: "mouseExit"
            PropertyChanges {
                target: content
                scale: 1.0
            }
        }
    ]

    onEntered: {
        state = "mouseEnter"
    }

    onExited: {
       state = "mouseExit"
    }

    onPressed: {
        state = "mouseExit"
    }

    onReleased: {
        state = "mouseEnter"
    }

    transitions: Transition {
        NumberAnimation {
            properties: "scale"
            duration: 50
        }
    }


    Item {
        id: content
        anchors.fill: parent

        Rectangle {
            id: background
            color: "#00ffffff"
            radius: parent.width / 2
            anchors.fill: parent
        }

        Image {
            id: image
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }




}
