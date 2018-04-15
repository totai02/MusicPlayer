import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

InteractiveArea {

    property alias title: text1.text
    property alias artist: text2.text
    property alias album: albumName.text
    property alias genre: genreName.text
    property alias length: text3.text


    width: 800
    height: 50

    onEntered: {
        checkBox.visible = true;
        item3.visible = true;
    }

    onExited: {
        checkBox.visible = false;
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
            Layout.fillHeight: true
            Layout.fillWidth: true

            RowLayout {
                id: rowLayout
                anchors.fill: parent

                Text {
                    id: text1
                    text: "See You Again"
                    font.bold: false
                    font.family: "Adobe Kaiti Std R"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    anchors.leftMargin: 0
                    elide: Text.ElideRight
                    fontSizeMode: Text.FixedSize
                    verticalAlignment: Text.AlignVCenter
                    renderType: Text.QtRendering
                    anchors.rightMargin: 100
                    font.pixelSize: 15
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
                        source: "img/play_black.png"
                        maximumize: false
                    }

                    IconButton {
                        id: iconButton1
                        width: 50
                        visible: true
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        source: "img/plus_black.png"
                        maximumize: false
                    }
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
                text: "Wiz Khalifa, Charlie Puth"
                font.bold: false
                font.family: "Adobe Fangsong Std R"
                font.weight: Font.Normal
                anchors.leftMargin: 10
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                font.pixelSize: 15
            }
        }

        Item {
            id: album
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: if (content.width > 900) {true} else {false}
            Text {
                id: albumName
                text: "Furious 7 OST"
                font.bold: false
                font.family: "Adobe Kaiti Std R"
                anchors.fill: parent
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.pixelSize: 15
            }
        }

        Item {
            id: genre
            width: 200
            height: 50
            Layout.fillHeight: true
            visible: if (content.width > 700) {true} else {false}
            Layout.fillWidth: true

            Text {
                id: genreName
                text: "Contemporary Pop"
                font.bold: false
                font.family: "Adobe Fangsong Std R"
                font.weight: Font.Normal
                anchors.fill: parent
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pixelSize: 15
            }
        }

        Item {
            id: time
            width: 70
            height: 50
            Layout.fillWidth: false

            Text {
                id: text3
                text: "3:49"
                font.bold: false
                font.family: "Adobe Fangsong Std R"
                font.weight: Font.Normal
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 15
            }
        }


    }

}
