import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

InteractiveArea {
    width: 800
    height: 50

    onEntered: {
        checkBox.visible = true;
        item3.visible = true;
    }

    onExited: {
        checkBox.visible = false;5555555555555555555
        item3.visible = false;
        onRelease.start();
    }

    onPressed: {
        onPress.start();
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
        spacing: 0
        anchors.fill: parent

        Item {
            id: select
            width: 50
            height: 50

            CheckBox {
                id: checkBox
                width: 40
                text: qsTr("")
                visible: false
                scale: 0.8
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Item {
            id: nameSong
            width: 200
            height: 50
            Layout.fillWidth: true

            Text {
                id: text1
                text: qsTr("See You Again")
                anchors.leftMargin: 0
                elide: Text.ElideRight
                fontSizeMode: Text.VerticalFit
                verticalAlignment: Text.AlignVCenter
                renderType: Text.NativeRendering
                anchors.rightMargin: 100
                anchors.fill: parent
                font.pixelSize: 14
            }

            Item {
                id: item3
                width: 100
                height: 50
                visible: false
                anchors.right: parent.right
                anchors.rightMargin: 0

                IconButton {
                    id: iconButton
                    width: 50
                    text: ""
                    visible: true
                    source: "img/play.png"
                    maximumize: false
                }

                IconButton {
                    id: iconButton1
                    width: 50
                    visible: true
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    source: "img/plus.png"
                    maximumize: false
                }
            }
        }

        Item {
            id: artist
            width: 250
            height: 50
            Layout.fillWidth: true

            Text {
                id: text2
                text: qsTr("Wiz Khalifa, Charlie Puth")
                anchors.leftMargin: 10
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                font.pixelSize: 13
            }
        }

        Item {
            id: other
            width: 200
            height: 50
            visible: if (content.width <= 700) {false} else {true}
            Layout.fillWidth: true

            RowLayout {
                id: rowLayout
                spacing: 0
                anchors.fill: parent

                Text {
                    id: albumName
                    text: qsTr("Furious 7 OST")
                    visible: if (content.width > 900) {true} else {false}
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    font.pixelSize: 13
                }

                Text {
                    id: genre
                    text: qsTr("Contemporary Pop")
                    visible: if (content.width > 700) {true} else {false}
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.pixelSize: 13
                }
            }
        }

        Item {
            id: time
            width: 70
            height: 50
            Layout.fillWidth: false

            Text {
                id: text3
                text: qsTr("3:49")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
            }
        }

    }

}
