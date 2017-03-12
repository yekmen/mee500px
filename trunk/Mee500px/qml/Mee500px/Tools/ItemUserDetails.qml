// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
Item {
    id: item1
//    width: 100
//    height: 62
    property string imagePath
    property string name
    property int size : 20
    Image{
        id: image
        width: size
        height: size
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        source: imagePath
    }
    Label{
        id: label
        width: 50
        height: 20
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: image.right
        anchors.leftMargin: 5
        color: "black"
        text: name
        font.pixelSize: 18
    }
}
