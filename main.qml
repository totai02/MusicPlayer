import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2

Window {
    id: window
    visible: true
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2
    width: 1024
    height: 700
    title: qsTr("Music Player")
    minimumWidth: 900
    minimumHeight: 700

    Connections{
        target: application

        onSendSignal: {
            if (value) loading.state = "show"
            else loading.state = "hide"
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a folder"
        folder: shortcuts.music
        selectFolder: true

        onAccepted: {
            folderList.append(fileDialog.fileUrls)
        }
    }

    Rectangle {
        id: loading
        width: 200
        height: 60
        color: "#2b7dbd"
        z: 10
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20

        state: "hide"

        states: [
            State {
                name: "show"
                PropertyChanges {
                    target: loading
                    opacity: 1
                }
            },
            State {
                name: "hide"
                PropertyChanges {
                    target: loading
                    opacity: 0
                }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation{
                    properties: "opacity"
                    duration: 50
                }
            }
        ]

        Image {
            id: image
            width: 60
            height: 60
            source: "img/replay.png"

            RotationAnimation on rotation {
                loops: Animation.Infinite
                duration: 700
                from: 0
                to: -360
            }
        }

        Text {
            id: text13
            color: "#ffffff"
            text: qsTr("Loading")
            font.bold: true
            anchors.left: parent.left
            anchors.leftMargin: 70
            font.family: "Tahoma"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 22
        }

    }

    Dialog {
        id: folderManager
        width: 500
        height: 400

        ColumnLayout {
            id: columnLayout2
            spacing: 10
            anchors.fill: parent

            Text {
                id: text11
                height: 50
                text: qsTr("Build your collection from your local music files")
                font.bold: true
                font.family: "Adobe Kaiti Std R"
                font.pixelSize: 20
            }

            Text {
                id: text12
                height: 50
                text: qsTr("Right now, we're watching these folders")
                font.family: "Adobe Kaiti Std R"
                font.pixelSize: 14
            }

            Button {
                id: button
                text: qsTr("Add")

                onClicked: fileDialog.visible = true
            }

            ListView {
                id: listView1
                x: 0
                y: 0
                width: 110
                height: 160
                Layout.fillHeight: true
                Layout.fillWidth: true
                clip: true

                model: folderModel
                delegate: FolderItem{
                    folderName: name
                    folderUrl: url
                    currentIndex: index

                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }


    }

    Dialog {
        id: settingDialog
        title: "Setting"
        width: 420
        height: 300

        Text {
            id: text8
            x: 30
            y: 39
            text: qsTr("Music on this PC")
            font.bold: true
            font.family: "Adobe Kaiti Std R"
            font.pixelSize: 22
        }

        MouseArea {
            id: mouseArea
            x: 31
            y: 70
            width: 176
            height: 18
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                folderManager.open()
            }

            Text {
                id: text9
                x: 0
                y: 0
                color: "#0d4689"
                text: qsTr("Choose where we look for music")
                font.pixelSize: 13
            }
        }


        Text {
            id: text10
            x: 30
            y: 113
            text: qsTr("Language")
            font.bold: true
            font.family: "Adobe Kaiti Std R"
            font.pixelSize: 20
        }


        ComboBox {
            id: comboBox
            y: 152
            height: 40
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.right: parent.right
            anchors.rightMargin: 30
            model: ["English", "Vietnamese"]
            onCurrentIndexChanged: console.log(model[currentIndex])
        }

    }

    Connections {
        target: musicList

        onLoadComplete:{
            text1.text = "Shuffle all (" + musicList.count() + ")"
        }
    }

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
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#8096bfff"
                        }

                        GradientStop {
                            position: 0.313
                            color: "#b381a4b5"
                        }

                        GradientStop {
                            position: 0.776
                            color: "#ffffff"
                        }

                        GradientStop {
                            position: 1
                            color: "#4c96bfff"
                        }


                    }

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

                        GroupButton {

                            current: iconButton

                            id: group
                            height: 150
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0

                            IconButton {
                                id: iconButton
                                x: 0
                                y: 0
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
                                id: iconButton2
                                x: 0
                                y: 100
                                height: 50
                                text: "Now playing"
                                toggle: true
                                anchors.right: parent.right
                                anchors.rightMargin: 0
                                anchors.left: parent.left
                                anchors.leftMargin: 0
                                source: "img/play_black.png"
                            }

                            IconButton {
                                id: iconButton1
                                x: 0
                                y: 50
                                height: 50
                                text: "Recent plays"
                                toggle: true
                                anchors.right: parent.right
                                anchors.rightMargin: 0
                                anchors.left: parent.left
                                anchors.leftMargin: 0
                                source: "img/clock.png"
                            }

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

                            onClicked: {
                                settingDialog.open()
                            }
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
                            gradient: Gradient {
                                GradientStop {
                                    position: 0.177
                                    color: "#4c96bfff"
                                }

                                GradientStop {
                                    position: 0
                                    color: "#8096bfff"
                                }

                                GradientStop {
                                    position: 0.629
                                    color: "#80ffffff"
                                }

                                GradientStop {
                                    position: 1
                                    color: "#ffffff"
                                }



                            }
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

                        GroupButton {
                            id: tabBar
                            current: toggleButton

                            ToggleButton{
                                id: toggleButton
                                text: "Songs"
                                x: 21
                                y: 80

                                onClicked: {
                                    stackLayout.currentIndex = 0;
                                }
                            }

                            ToggleButton{
                                id: toggleButton2
                                x: 107
                                y: 80

                                text: "Artists"

                                onClicked: {
                                    stackLayout.currentIndex = 1;
                                }
                            }

                            ToggleButton{
                                id: toggleButton3
                                x: 193
                                y: 80

                                text: "Albums"

                                onClicked: {
                                    stackLayout.currentIndex = 2;
                                }
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
                            text: "Shuffle all (" + musicList.count() + ")"
                            style: Text.Normal
                            font.weight: Font.Thin
                            font.family: "Adobe Kaiti Std R"
                            font.pixelSize: 13
                        }

                        Text {
                            id: text2
                            x: 169
                            y: 136
                            text: qsTr("Sort by:")
                            font.family: "Adobe Kaiti Std R"
                            font.pixelSize: 13
                        }

                        Text {
                            id: text3
                            x: 220
                            y: 136
                            color: "#085bad"
                            text: qsTr("Date added")
                            font.family: "Adobe Kaiti Std R"
                            font.pixelSize: 13
                        }

                        Text {
                            id: text4
                            x: 322
                            y: 136
                            text: qsTr("Filter:")
                            font.family: "Adobe Kaiti Std R"
                            font.pixelSize: 13
                        }

                        Text {
                            id: text5
                            x: 362
                            y: 136
                            color: "#085bad"
                            text: qsTr("All")
                            font.family: "Adobe Kaiti Std R"
                            font.pixelSize: 13
                        }

                        Text {
                            id: text6
                            x: 413
                            y: 136
                            text: qsTr("Genre:")
                            font.family: "Adobe Kaiti Std R"
                            font.pixelSize: 13
                        }

                        Text {
                            id: text7
                            x: 459
                            y: 136
                            color: "#085bad"
                            text: qsTr("All genres")
                            font.family: "Adobe Kaiti Std R"
                            font.pixelSize: 13
                        }

                    }

                    StackLayout {
                        id: stackLayout
                        width: 100
                        height: 100
                        currentIndex: 0
                        Layout.fillHeight: true
                        Layout.fillWidth: true

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
                                model: musicModel
                                delegate: MusicItem{
                                    title: model.title
                                    artist: model.artist
                                    album: model.album
                                    genre: model.genre
                                    length: Math.floor(model.length / 60) + ":" + (model.length % 60 < 10 ? ("0" + model.length % 60) : model.length % 60)
                                    width: parent.width
                                    bgColor: (index % 2 == 0) ? "white" : "#eeeeee"
                                    hoverColor: "#4c808080"

                                    onClicked: {
                                        musicPlayer.play(index);
                                    }
                                }

                            }

                            Component.onCompleted: {
                                musicList.loadMusicInFolders();
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
            }

        }

    }

}
