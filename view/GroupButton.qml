import QtQuick 2.0

Item {
    property var current

    function change(button){
        current.checked = false;
        current =  button;
    }

    Component.onCompleted: {
        current.checked = true;
    }
}
