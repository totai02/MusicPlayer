import QtQuick 2.0

InteractiveArea {

    property alias folderName: text1.text
    property alias folderUrl: text2.text

    signal removeClick(var index)

    width: 300
    height: 70


    Rectangle {
        id: rectangle
        color: "#4ca6a6a6"
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        anchors.fill: parent
    }

    Item {
        id: item1
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        anchors.fill: parent

        Text {
            id: text1
            y: 7
            text: "Folder Name"
            elide: Text.ElideRight
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 50
            font.bold: true
            font.family: "Tahoma"
            font.pixelSize: 14
        }

        Text {
            id: text2
            y: 35
            text: "Folder URL"
            elide: Text.ElideRight
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 0
            font.pixelSize: 14
        }

        IconButton {
            id: iconButton
            width: 40
            height: 40
            anchors.verticalCenter: parent.verticalCenter
            source: "img/x_icon.png"
            anchors.right: parent.right
            anchors.rightMargin: 0
            maximumize: false

            onClicked: {
                removeClick(index)
            }
        }
    }


}
