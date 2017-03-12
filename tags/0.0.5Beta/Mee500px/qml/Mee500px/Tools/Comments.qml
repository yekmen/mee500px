// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: itemComments
    property ListModel modelComments
//    anchors.fill: parent
//    width: 480
//    height: 640
//    Component.onCompleted: console.debug("Yes : " + modelComments.count)
    Rectangle{
        id: sepComments
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        z:1
        color: "black"
        height: 50
        GroupSeparator{
            title: "Comments"
            anchors.fill: parent
        }
    }

    ListView{
        id: listComments
        height: 400
        anchors.top: sepComments.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.topMargin: 0
        model:modelComments
        z:-1
        delegate: DelegateComments{

        }
    }
    GroupSeparator{
        id: sepAddComments
        title: "New Comments"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: listComments.bottom
        anchors.topMargin: 50

    }
    TextArea{
        id: areaComment
        height: 200
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: sepAddComments.bottom
        anchors.topMargin: 0
        visible: false
    }
}
