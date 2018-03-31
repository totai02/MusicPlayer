import QtQuick 2.0
import QtQuick.Layouts 1.3

InteractiveArea {

    property alias text: label.text
    property alias source: icon.source
    property alias maximumize: item3.visible
    property bool toggle: false
    property bool checked: false

    signal send3(string msg)

    width: 200
    height: 50

    onPressed: {
        onPress.start();
        if (toggle) checked = true;
    }

    onReleased: {
        onRelease.start();
    }

    NumberAnimation {
        id: onPress
        target: content
        properties: "scale"
        to: 0.8
        duration: 50
    }

    NumberAnimation {
        id: onRelease
        target: content
        properties: "scale"
        to: 1.0
        duration: 30
    }

    RowLayout {
        id: content
        width: 50
        spacing: 0
        anchors.fill: parent

        Item {
            id: checkItem
            width: 5
            visible: checked
            Layout.fillHeight: true

            Rectangle {
                id: rectangle
                color: "#2374ae"
                anchors.fill: parent
            }
        }

        Item {
            id: item2
            width: parent.height
            height: parent.height
            visible: true
            Layout.fillHeight: false
            Layout.fillWidth: false

            Image {
                id: icon
                width: parent.height * 0.5
                height: parent.height * 0.5
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Item {
            id: item3
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.fillWidth: true

            Text {
                id: label
                text: qsTr("Button")
                font.weight: Font.Thin
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 11
            }
        }
    }

}
