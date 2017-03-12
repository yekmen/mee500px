import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {
    id: rectangle1
    width: parent.width
    height: 2
    color:"transparent"

    Rectangle {
        id: sortingDivisionLine
        anchors.verticalCenter: parent.verticalCenter
        x:0
        width: parent.width
        height: 1
        color: "gray"
        opacity: 0.3
    }

    Rectangle {
        anchors.top: sortingDivisionLine.bottom
        x:0
        width: parent.width
        height: 1
        color: theme.inverted? "darkgray" : "white"
        opacity: theme.inverted? 0.3 : 0.5
    }
}
