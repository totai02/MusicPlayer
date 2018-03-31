import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    height: 100
    property alias customButton2: customButton2
    width: 1024
    Rectangle {
        id: rectangle
        color: "#2374ae"
        radius: 0
        anchors.fill: parent
    }

    RowLayout {
        id: rowLayout
        spacing: 10
        anchors.fill: parent

        StackView {
            id: stackView
            width: 300
            height: parent.height

            Row {
                id: row
                width: 250
                spacing: 5
                clip: true
                anchors.fill: parent

                StackView {
                    id: stackView3
                    width: 100
                    height: 100

                    Image {
                        id: image
                        width: 100
                        height: 100
                        source: "img/avatar.png"
                    }
                }

                ScrollView {
                    id: scrollView
                    height: 100
                    anchors.left: parent.left
                    anchors.leftMargin: 110
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    font.capitalization: Font.MixedCase
                    contentHeight: 100
                    contentWidth: 100
                    font.pointSize: 6
                    clip: true

                    Label {
                        id: label
                        color: "#ffffff"
                        text: qsTr("Timber")
                        font.pointSize: 12
                        anchors.top: parent.top
                        anchors.topMargin: 30
                    }

                    Label {
                        id: label1
                        width: 190
                        height: 19
                        color: "#ffffff"
                        text: qsTr("Pitbull, Ke - Global Warming Meltdown")
                        elide: Text.ElideRight
                        font.bold: true
                        font.pointSize: 12
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 30
                    }
                }
            }
        }

        StackView {
            id: stackView1
            width: 200
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
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            imageSource: "img/shuffle_white.png"
                        }

                        CircleButton {
                            id: customButton1
                            width: 40
                            height: 40
                            imageSource: "img/skip-prev.png"
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }

                        CircleButton {
                            id: customButton2
                            width: 48
                            height: 48
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            imageSource: "img/pause.png"
                        }

                        CircleButton {
                            id: customButton3
                            width: 40
                            height: 40
                            imageSource: "img/skip-next.png"
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }

                        CircleButton {
                            id: customButton4
                            width: 40
                            height: 40
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            imageSource: "img/replay.png"
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
                        anchors.rightMargin: 60
                        anchors.leftMargin: 60
                        anchors.fill: parent

                        Label {
                            id: label2
                            color: "#ffffff"
                            text: qsTr("3:02")
                            font.pointSize: 10
                        }

                        ProgressBar {
                            id: progressBar
                            Layout.fillWidth: true
                            value: 0.75
                        }

                        Label {
                            id: label3
                            color: "#ffffff"
                            text: qsTr("4:01")
                            font.pointSize: 10
                        }

                    }
                }
            }

        }

        StackView {
            id: stackView2
            width: 250
            height: parent.height
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

            Column {
                id: column1
                spacing: 10
                anchors.fill: parent

                CircleButton {
                    id: customButton5
                    width: 40
                    height: 40
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    imageSource: "img/volumn.png"
                }

                Slider {
                    id: slider1
                    height: 10
                    scale: 0.7
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    value: 0.5
                }

            }
        }
    }

}
