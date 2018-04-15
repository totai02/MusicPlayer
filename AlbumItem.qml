import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

InteractiveArea {

    property alias albumName: albumLabel.text
    property alias artistName: artistNameLabel.text

    id: albumItem
    width: 150
    height: 200
    clip: false
    hoverColor: "#00ffffff"
    property alias imageSource : img.source

    onEntered: {
        glowEffect.visible = true;
    }

    onExited: {
        glowEffect.visible = false;
    }

    Glow {
        id: glowEffect
        visible: false
        anchors.fill: img
        radius: 15
        samples: 17
        color: "#66808080"
        source: img
    }

    Image {
        id: img
        source: 'img/album.png'
        width: 150
        height: 150
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent

        onEntered: {
            onShow.start()
        }

        onExited: {
            onHide.start()
        }

        NumberAnimation {
            id: onShow
            target: buttonContainer
            properties: "opacity, scale"
            to: 1.0
            duration: 50
        }

        NumberAnimation {
            id: onHide
            target: buttonContainer
            properties: "opacity, scale"
            to: 0.0
            duration: 50
        }

        Item{
            id: buttonContainer
            anchors.fill: parent
            opacity: 0

            CircleButton {
                id: playBtn
                width: 50
                height: 50
                bgColor: "#1473a2"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 50
                imageSource: "img/play.png"
            }

            CircleButton {
                id: addPlayList
                width: 50
                height: 50
                bgColor: "#1473a2"
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 50
                imageSource: "img/plus.png"
            }
        }
    }

    Text {
        id: albumLabel
        text: qsTr("Faded - Single")
        font.weight: Font.Bold
        font.family: "Adobe Heiti Std R"
        elide: Text.ElideRight
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 5
        font.bold: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        font.pixelSize: 17
    }

    Text {
        id: artistNameLabel
        text: qsTr("Alan Walker")
        font.family: "Adobe Kaiti Std R"
        elide: Text.ElideRight
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 7
        font.pixelSize: 14
    }

}

