import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    height: 100
    property alias customButton2: customButton2
    width: 1024
    Rectangle {
        id: rectangle
        color: "#1473a2"
        radius: 0
        anchors.fill: parent
    }

    Connections {
        target: musicPlayer

        function updateView(isPlay){

            label.text = musicPlayer.getMusicTitle()
            label1.text = musicPlayer.getMusicArtist()
            label2.text = musicPlayer.getMusicDuration()
            label3.text = musicPlayer.getMusicLength()

            if (isPlay) {
                customButton2.imageSource = "img/pause.png"
                progressBar.enabled = true;
            } else {
                customButton2.imageSource = "img/play-circle.png"
                progressBar.enabled = false;
            }
        }

        onPlayPause:{
            updateView(isPlay);
        }

        onUpdateInfoSuccess:{
            updateView(false);
        }

        onUpdateDuration: {
            label2.text = musicPlayer.getMusicDuration()
            progressBar.value = musicPlayer.getProgress();
        }
    }

    RowLayout {
        id: rowLayout
        spacing: 10
        anchors.fill: parent

            Item {
                id: stackView
                height: parent.height
                Layout.fillWidth: true

                InteractiveArea {
                    hoverColor: "#144f78"
                    anchors.fill: parent

                    Row {
                        id: row
                        width: 250
                        spacing: 5
                        clip: true
                        anchors.fill: parent

                        Item {
                            id: stackView3
                            width: 100
                            height: 100

                            Image {
                                id: image
                                width: 100
                                height: 100
                                source: "img/music_icon.png"
                            }
                        }

                        Item {
                            id: container
                            height: 100
                            anchors.left: parent.left
                            anchors.leftMargin: 110
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            clip: true

                            Label {
                                id: label
                                color: "#ffffff"
                                text: musicPlayer.getMusicTitle()
                                font.family: "Adobe Kaiti Std R"
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                font.pointSize: 14
                                anchors.top: parent.top
                                anchors.topMargin: 20
                            }

                            Label {
                                id: label1
                                height: 19
                                color: "#ffffff"
                                text: musicPlayer.getMusicArtist()
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                elide: Text.ElideRight
                                font.bold: true
                                font.pointSize: 12
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 27
                            }
                        }
                    }
                }
             }
        Item {
            id: stackView1
            height: parent.height
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Column {
                id: column
                anchors.fill: parent

                Row {
                    id: row1
                    y: 0
                    height: 60
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0

                    RowLayout {
                        id: rowLayout2
                        y: 0
                        width: 300
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 0

                        CircleButton {
                            id: customButton
                            width: 40
                            height: 40
                            toggle: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            imageSource: "img/shuffle_white.png"

                            onClicked: {
                                musicPlayer.setShuffle(checked);
                            }
                        }

                        CircleButton {
                            id: customButton1
                            width: 40
                            height: 40
                            imageSource: "img/skip-prev.png"
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                            onClicked: {
                                musicPlayer.prevMedia();
                            }
                        }

                        CircleButton {

                            id: customButton2
                            width: 48
                            height: 48
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            imageSource: "img/play-circle.png"

                            onClicked: {
                                if (musicPlayer.isPlaying()) {
                                    imageSource = "img/pause.png";
                                    musicPlayer.pause();
                                }
                                else {
                                    imageSource = "img/play-circle.png"
                                    musicPlayer.cont();
                                }
                            }

                        }

                        CircleButton {
                            id: customButton3
                            width: 40
                            height: 40
                            imageSource: "img/skip-next.png"
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                            onClicked: {
                                musicPlayer.nextMedia();
                            }
                        }

                        CircleButton {
                            id: customButton4
                            width: 40
                            height: 40
                            toggle: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            imageSource: "img/replay.png"

                            onClicked: {
                                musicPlayer.setLoop(checked);
                            }
                        }
                    }
                }

                Row {
                    id: row2
                    height: 40
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0

                    RowLayout {
                        id: rowLayout1
                        anchors.fill: parent

                        Label {
                            id: label2
                            color: "#ffffff"
                            text: "00:00"
                            font.pointSize: 10
                        }

                        Slider {
                            id: progressBar
                            enabled: false
                            Layout.fillWidth: true
                            value: 0

                            onMoved: {
                                musicPlayer.setMediaPosition(value)
                            }
                        }

                        Label {
                            id: label3
                            color: "#ffffff"
                            text: "00:00"
                            font.pointSize: 10
                        }

                    }
                }
            }

        }

        Item {
            id: stackView2
            height: parent.height
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

            Column {
                id: column1
                spacing: 10
                anchors.fill: parent

                CircleButton {
                    property var currentVolumn: musicPlayer.getVolumn()

                    id: customButton5
                    width: 40
                    height: 40
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    anchors.right: parent.right
                    anchors.rightMargin: 190
                    imageSource: "img/volumn.png"

                    onClicked: {
                        if (musicPlayer.getVolumn() !== 0) {
                            currentVolumn = musicPlayer.getVolumn();
                            musicPlayer.setVolumn(0);
                            imageSource = "img/volumn-mute.png"
                            slider1.value = 0;
                        } else {
                            musicPlayer.setVolumn(currentVolumn);
                            imageSource = "img/volumn.png"
                            slider1.value = currentVolumn;
                        }
                    }
                }

                Slider {
                    id: slider1
                    height: 10
                    stepSize: 10
                    to: 100
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    scale: 0.7
                    value: musicPlayer.getVolumn()

                    onValueChanged: {
                        musicPlayer.setVolumn(value);
                    }
                }

            }
        }
    }

}
