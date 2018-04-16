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
    title: "Music Player"
    minimumWidth: 900
    minimumHeight: 700

    Connections{
        target: application

        onSendSignal: {
            if (value) loading.state = "show"
            else loading.state = "hide"
        }
    }

    Connections {
        target: musicList

        onLoadComplete:{
            musicControl.mediaPos.enabled = true
            stackLayout.currentIndex = 0
            text1.text = qsTr("Shuffle all (") + musicList.count() + ")"
        }

        onEmptyToShow: {
            stackLayout.currentIndex = 3
        }
    }

    FileDialog {
        id: fileDialog
        title: qsTr("Please choose a folder")
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

        state: if (application.isLoading()) return "show"; else return "hide";

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
                font.family: "Times New Roman"
                font.pixelSize: 20
            }

            Text {
                id: text12
                height: 50
                text: qsTr("Right now, we're watching these folders")
                font.family: "Times New Roman"
                font.pixelSize: 16
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

                    anchors.horizontalCenter: parent.horizontalCenter

                    onRemoveClick: {
                        folderList.removeRow(index)
                    }
                }
            }
        }


    }

    Dialog {
        id: settingDialog
        title: qsTr("Setting")
        width: 420
        height: 300

        Text {
            id: text8
            x: 30
            y: 39
            text: qsTr("Music on this PC")
            font.bold: true
            font.family: "Times New Roman"
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
            font.family: "Times New Roman"
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
            currentIndex: application.getLanguage()
            model: ["English", "France","Vietnamese"]
            onCurrentIndexChanged: {
                if (settingDialog.visible) {
                    changeLanguage.open()
                }
            }

            Dialog {
                id: changeLanguage
                title: qsTr("Restart Required")
                standardButtons: StandardButton.Yes | StandardButton.No

                Row{
                    spacing: 10

                    Image {
                        id: warningImg
                        source: "img/warning.png"

                        width: 50
                        height: 50
                    }

                    Text {
                        id: changeLanguageLabel

                        font.pixelSize: 14
                        text: qsTr("The language change will take effect after restart.")
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }


                onYes: {
                    application.changeLanguage(comboBox.currentIndex)
                }
            }
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
                                text: qsTr("My music")
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
                                text: qsTr("Now playing")
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
                                text: qsTr("Recent plays")
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
                            text: qsTr("Playlists")
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
                            text: qsTr("Setting")
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
                                text: qsTr("Songs")
                                x: 21
                                y: 80

                                onClicked: {

                                    if (stackLayout.currentIndex != 3) stackLayout.currentIndex = 0;
                                }
                            }

                            ToggleButton{
                                id: toggleButton2
                                x: 107
                                y: 80

                                text: qsTr("Artists")

                                onClicked: {
                                    if (stackLayout.currentIndex != 3) stackLayout.currentIndex = 1;
                                }
                            }

                            ToggleButton{
                                id: toggleButton3
                                x: 193
                                y: 80

                                text: qsTr("Albums")

                                onClicked: {
                                    if (stackLayout.currentIndex != 3) stackLayout.currentIndex = 2;
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
                            text: qsTr("Shuffle all (0)")
                            style: Text.Normal
                            font.weight: Font.Thin
                            font.family: "Times New Roman"
                            font.pixelSize: 14
                        }

                        Text {
                            id: text2
                            x: text1.x + text1.width + 30
                            y: 136
                            text: qsTr("Sort by:")
                            font.family: "Times New Roman"
                            font.pixelSize: 14
                        }

                        Text {
                            id: text3
                            x: text2.x + text2.width + 5
                            y: 136
                            color: "#085bad"
                            text: qsTr("Date added")
                            font.family: "Times New Roman"
                            font.pixelSize: 14
                        }

                        Text {
                            id: text4
                            x: text3.x + text3.width + 30
                            y: 136
                            text: qsTr("Filter:")
                            font.family: "Times New Roman"
                            font.pixelSize: 14
                        }

                        Text {
                            id: text5
                            x: text4.x + text4.width + 5
                            y: 136
                            color: "#085bad"
                            text: qsTr("All")
                            font.family: "Times New Roman"
                            font.pixelSize: 14
                        }

                        Text {
                            id: text6
                            x: text5.x + text5.width + 30
                            y: 136
                            text: qsTr("Genre:")
                            font.family: "Times New Roman"
                            font.pixelSize: 14
                        }

                        Text {
                            id: text7
                            x: text6.x + text6.width + 5
                            y: 136
                            color: "#085bad"
                            text: qsTr("All genres")
                            font.family: "Times New Roman"
                            font.pixelSize: 14
                        }

                    }

                    StackLayout {
                        id: stackLayout
                        width: 100
                        height: 100
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Row {
                            id: row3
                            width: 200
                            height: 400

                            ListView {
                                id: listView
                                boundsBehavior: Flickable.DragAndOvershootBounds
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

                                ScrollBar.vertical: ScrollBar {
                                    parent: listView.parent
                                    anchors.top: listView.top
                                    anchors.left: listView.right
                                    anchors.bottom: listView.bottom
                                }

                            }
                        }

                        Row {
                            id: row1
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            Flickable {


                                id: flickable
                                clip: true
                                contentWidth: parent.width
                                contentHeight: column3.childrenRect.height
                                anchors.fill: parent

                                ScrollBar.vertical: ScrollBar { }

                                Column {
                                    id: column3
                                    width: parent.width
                                    height: repeater.childrenRect.height

                                    Repeater{
                                        id: repeater
                                        width: parent.width
                                        height: childrenRect.height
                                        model: artistModel


                                        ColumnLayout {

                                            property var data1: model

                                            width: parent.width
                                            height: flow1.childrenRect.height + 50

                                            Item{

                                                id: item1
                                                height: 50
                                                width: parent.width

                                                Item {

                                                    width: 100
                                                    height: 50

                                                    Rectangle{
                                                        width: 50
                                                        height: 30
                                                        color: "#6c5454"
                                                        radius: 15
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        anchors.verticalCenter: parent.verticalCenter

                                                    }

                                                    Text {
                                                        id: text14
                                                        x: 26
                                                        color: "#ffffff"
                                                        text: data1.groupName
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        font.pixelSize: 20
                                                    }

                                                }
                                            }


                                            Flow {

                                                id: flow1


                                                height: repeater1.childrenRect.height
                                                Layout.fillWidth: true

                                                Repeater {

                                                    id: repeater1
                                                    model: data1.artistList

                                                    height: childrenRect.height
                                                    ArtistItem{
                                                        artist: modelData
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
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
                                model: albumModel
                                cellWidth: 200
                                cellHeight: 200
                                delegate: AlbumItem{
                                    albumName: model.album
                                    artistName: model.artist
                                }

                                ScrollBar.vertical: ScrollBar {
                                    parent: gridView1.parent
                                    anchors.top: gridView1.top
                                    anchors.left: gridView1.right
                                    anchors.bottom: gridView1.bottom
                                }
                            }
                        }

                        Column {
                            id: row4
                            width: 200
                            height: 400
                            spacing: 10
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            Text {
                                id: text15
                                text: qsTr("Nothing to show here.")
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 20
                            }

                            Text {
                                id: text16
                                color: "#1163c9"
                                text: qsTr("Add music")
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 16

                                MouseArea {
                                    id: mouseArea1
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor

                                    onClicked: {
                                        folderManager.open()
                                    }
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
