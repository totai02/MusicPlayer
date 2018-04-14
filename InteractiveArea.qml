import QtQuick 2.0

MouseArea {

    property alias bgColor: background.color
    property alias hoverColor: hover.color
    property alias radius: hover.radius

    cursorShape: Qt.PointingHandCursor

    width: 100
    height: 100
    hoverEnabled: true

    onEntered: {
        hover.visible = true;
    }

    onExited: {
        hover.visible = false;
    }

    Rectangle {
        id: hover
        color: "#33808080"
        z: 0
        visible: false
        anchors.fill: parent
    }

    Rectangle {
        id: background
        color: "#00ffffff"
        anchors.fill: parent
        radius: hover.radius
        visible: true
        z: -1
    }


}
