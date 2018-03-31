import QtQuick 2.0

InteractiveArea {
    property alias imageSource: image.source
    property alias bgColor: background.color
    property var font
    font: { pixelSize: 12; b: true }

    width: 70
    height: 70

    hoverColor: "#80144f78"
    radius: 35
    clip: false

    onEntered: {
        onEnter.start();
    }

    onExited: {
       onExit.start()
    }

    onPressed: {
        onExit.start()
    }

    onReleased: {
        onEnter.start();
    }

    NumberAnimation {
        id: onEnter
        target: content
        properties: "scale"
        to: 1.2
        duration: 50
    }



    NumberAnimation {
        id: onExit
        target: content
        properties: "scale"
        to: 1.0
        duration: 50
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
