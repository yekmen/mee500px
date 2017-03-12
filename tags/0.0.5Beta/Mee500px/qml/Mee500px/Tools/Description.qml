// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: item1
//    width: 480
//    height: 800
//    property variant descrip
    function setText(value){
        if(value)
        {
            areaDescription.text = value
        }
        else
        {
            areaDescription.text = ""
            areaDescription.placeholderText = "None description ... "
        }
    }
    GroupSeparator{
        id: sepDescription
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        title: "Description"
    }
    Flickable{
        anchors.top: sepDescription.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        contentHeight: areaDescription.height
        height: 200
        z:-1
        TextArea{
            id: areaDescription
            //                anchors.fill: parent
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            readOnly: true
            wrapMode: Text.WordWrap
            z:-1
        }
    }
}
