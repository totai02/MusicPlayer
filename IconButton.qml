import QtQuick 2.0
import QtQuick.Layouts 1.3

InteractiveArea {

    property alias text: label.text
    property alias source: icon.source
    property alias maximumize: item3.visible
    property bool toggle: false
    property bool checked: false

    width: 200
    height: 50

    states: [
        State {
            name: "mousePress"
            when: pressed
            PropertyChanges {
                target: content
                scale: 0.8
            }
        },
        State {
            name: "mouseRelease"
            when: released
            PropertyChanges {
                target: content
                scale: 1.0
            }
        }
    ]

    onPressed: {
        if (toggle) checked = true;
    }

    transitions: [
        Transition {
            to: "mousePress"
            NumberAnimation{
                to: 0.8
                properties: "scale"
                duration: 50
            }
        },
        Transition {
            to: "mouseRelease"
            NumberAnimation{
                to: 1.0
                properties: "scale"
                duration: 30
            }
        }
    ]

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
