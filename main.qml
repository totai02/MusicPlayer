import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import SongModel 1.0

Window {
    visible: true
    width: 800
    height: 600
    title: qsTr("Music Player")
    minimumWidth: 960
    minimumHeight: 500


    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        spacing: 0

        RowLayout {
            id: rowLayout
            width: 100
            height: 100
            spacing: 0

            Column {
                id: column
                width: 250
                height: 400
                Layout.fillHeight: true

                Rectangle {
                    id: rectangle
                    width: parent.width
                    height: parent.height
                    color: "#e6e6e6"

                    Column {
                        id: column2
                        spacing: 2
                        anchors.fill: parent

                        IconButton {
                            id: button6
                            width: 50
                            maximumize: false
                            source: "img/menu.png"
                        }

                        Row {
                            id: row
                            width: parent.width
                            height: 50

                            SearchInput {
                                id: searchInput
                                anchors.fill: parent
                            }
                        }

                        IconButton {
                            id: iconButton
                            height: 50
                            text: "My music"
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            source: "img/music.png"
                            toggle: true
                        }

                        IconButton {
                            id: iconButton1
                            height: 50
                            text: "Recent plays"
                            toggle: true
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            source: "img/clock.png"
                        }

                        IconButton {
                            id: iconButton2
                            height: 50
                            text: "Now playing"
                            toggle: true
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            source: "img/play.png"
                        }

                        ToolSeparator {
                            id: toolSeparator
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            orientation: Qt.Horizontal
                        }




                        IconButton {
                            id: iconButton3
                            text: "Playlists"
                            source: "img/playlist.png"
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                        }


                    }

                    Item {
                        id: stackView
                        width: parent.width
                        height: 100
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0

                        ToolSeparator {
                            id: toolSeparator2
                            y: 25
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            orientation: Qt.Horizontal
                        }

                        IconButton {
                            id: iconButton4
                            height: 50
                            text: "Setting"
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            source: "img/setting.png"
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                        }

                    }
                }

            }

            Column {
                id: column1
                width: 200
                height: 400
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    id: columnLayout1
                    spacing: 0
                    anchors.fill: parent


                    StackView {
                        id: stackView1
                        width: 200
                        height: 160
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                        Rectangle {
                            id: rectangle1
                            height: 200
                            color: "#ffffff"
                            anchors.fill: parent
                        }

                        Label {
                            id: label
                            x: 32
                            y: 24
                            width: 148
                            height: 44
                            text: qsTr("My Music")
                            font.bold: false
                            font.pointSize: 23
                        }

                        TabBar {
                            id: tabBar
                            x: 24
                            y: 74
                            width: 240

                            TabButton {
                                id: tabButton
                                text: qsTr("Songs")
                            }

                            TabButton {
                                id: tabButton1
                                text: qsTr("Artists")
                            }

                            TabButton {
                                id: tabButton2
                                text: qsTr("Albums")
                            }
                        }

                        ToolSeparator {
                            id: toolSeparator1
                            y: 115
                            height: 13
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            orientation: Qt.Horizontal
                        }

                        Image {
                            id: image6
                            x: 24
                            y: 131
                            width: 24
                            height: 24
                            source: "img/shuffle.png"
                        }

                        Text {
                            id: text1
                            x: 57
                            y: 136
                            text: qsTr("Shuffle all (20)")
                            style: Text.Normal
                            font.weight: Font.Thin
                            font.family: "Tahoma"
                            font.pixelSize: 13
                        }

                        Text {
                            id: text2
                            x: 169
                            y: 136
                            text: qsTr("Sort by:")
                            font.family: "Tahoma"
                            font.pixelSize: 13
                        }

                        Text {
                            id: text3
                            x: 220
                            y: 136
                            color: "#085bad"
                            text: qsTr("Date added")
                            font.family: "Tahoma"
                            font.pixelSize: 13
                        }

                        Text {
                            id: text4
                            x: 322
                            y: 136
                            text: qsTr("Filter:")
                            font.family: "Tahoma"
                            font.pixelSize: 13
                        }

                        Text {
                            id: text5
                            x: 362
                            y: 136
                            color: "#085bad"
                            text: qsTr("All")
                            font.family: "Tahoma"
                            font.pixelSize: 13
                        }

                        Text {
                            id: text6
                            x: 413
                            y: 136
                            text: qsTr("Genre:")
                            font.family: "Tahoma"
                            font.pixelSize: 13
                        }

                        Text {
                            id: text7
                            x: 459
                            y: 136
                            color: "#085bad"
                            text: qsTr("All genres")
                            font.family: "Tahoma"
                            font.pixelSize: 13
                        }

                    }

                    StackLayout {
                        id: stackLayout
                        width: 100
                        height: 100
                        currentIndex: tabBar.currentIndex
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        states: [
                            State {
                                name: "focus"
                                PropertyChanges {
                                    target: stackLayout
                                    opacity: 1.0
                                }
                            },
                            State {
                                name: "unfocus"
                                PropertyChanges {
                                    target: stackLayout
                                    opacity: 0
                                }
                            }
                        ]

                        transitions: Transition {
                            NumberAnimation{
                                properties: "opacity"
                                duration: 300
                            }
                        }

                        Row {
                            id: row3
                            width: 200
                            height: 400

                            ListView {
                                id: listView
                                anchors.rightMargin: 20
                                anchors.leftMargin: 20
                                anchors.fill: parent
                                clip: true
                                Layout.fillHeight: true
                                Layout.fillWidth: true

                                ScrollBar.vertical: ScrollBar {
                                    parent: listView.parent
                                    anchors.top: listView.top
                                    anchors.left: listView.right
                                    anchors.bottom: listView.bottom
                                }

                                model: SongModel{}
                                delegate: SongItem{

                                    title: model.title
                                    artist: model.artist
                                    album: model.album
                                    genre: model.genre
                                    length: Math.round(model.length / 60) + ":" + (model.length % 60 < 10 ? ("0" + model.length % 60) : model.length % 60)

                                    width: parent.width
                                    bgColor: (index % 2 == 0) ? "white" : "#eeeeee"
                                    hoverColor: "#4c808080"

                                    onClicked: {
                                        stackLayout.state = "unfocus"
                                        musicControl.state = "focus"
                                    }
                                }

                            }
                        }

                        Row {
                            id: row1
                            width: parent.width
                            height: parent.width
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            GridView {
                                id: gridView
                                anchors.rightMargin: 20
                                anchors.leftMargin: 0
                                anchors.fill: parent
                                highlightRangeMode: GridView.ApplyRange
                                clip: true
                                flickableDirection: Flickable.VerticalFlick
                                delegate: ArtistItem{
                                    imageSource: (index % 2 == 0) ? "img/avatar.png" : "img/album.jpg"
                                }
                                cellHeight: 200
                                cellWidth: 200
                                model: 20
                            }
                        }

                        Row {
                            id: row2
                            width: parent.width
                            height: parent.width

                            GridView {
                                id: gridView1
                                anchors.rightMargin: 20
                                anchors.leftMargin: 20
                                clip: true
                                anchors.fill: parent
                                model: 20
                                cellWidth: 200
                                cellHeight: 200
                                delegate: AlbumItem{
                                    imageSource: (index % 2 == 0) ? "img/avatar.png" : "img/album.jpg"
                                }
                            }
                        }


                    }
                }
            }
        }

        RowLayout {
            id: rowLayout1
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 0

            ControlBar {
                id: musicControl
                Layout.fillWidth: true

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        stackLayout.state = "focus"
                        musicControl.state = "unfocus"
                    }
                }

                states: [
                    State {
                        name: "focus"
                        PropertyChanges {
                            target: musicControl
                            opacity: 1.0
                        }
                    },
                    State {
                        name: "unfocus"
                        PropertyChanges {
                            target: musicControl
                            opacity: 0
                        }
                    }
                ]

                transitions: Transition {
                    NumberAnimation{
                        properties: "opacity"
                        duration: 300
                    }
                }
            }

        }

    }
}
