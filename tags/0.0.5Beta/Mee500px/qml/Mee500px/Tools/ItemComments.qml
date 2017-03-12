// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
Item {
    id: itemComments
    width: 200
    height: 200
    anchors.fill: parent
    property variant sourceLink
    JSONListModel {
        id: jsonModel
//        source:"https://api.500px.com/v1/photos?feature="+type+"&consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX&image_size=2&rpp=100"
//        source: "https://api.500px.com/v1/photos/38326040/comments?consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX"
        source: sourceLink;
        query: "$.comments[*]"
    }
    ListView{
        id: listview
        anchors.fill: parent
        model: jsonModel.model
        delegate:Component {
            Item {
                id: mainItem
//                width: 200
//                height: 200
                height: label_comments.height + label_userName.height + imageUser.height
                anchors.left: parent.left
                anchors.right: parent.right
                property variant retJSON
                Rectangle{
                    id: mainRect
                    anchors.fill: parent
                    Image{
                        id: imageUser
                        source: model.user.userpic_url
                        width: 50
                        height: 50
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        anchors.top: parent.top
                        anchors.topMargin: 0

                    }
                    Label{
                        id: label_userName
                        height: 20
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: imageUser.right
                        anchors.leftMargin: 10
                        text: model.user.username
                        color: "black"
                    }

                    Separator{
                        id: separator1
                        height: 5
                        anchors.top: label_userName.bottom
                        anchors.topMargin: 5
                        anchors.left: imageUser.right
                        anchors.leftMargin: 0
                        anchors.right: parent.right
                        anchors.rightMargin: 0

                    }
                    Label{
                        id: label_comments
                        text: model.body
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        anchors.top: imageUser.bottom
                        anchors.topMargin: 5
                        color: "black"

                    }
                }
            }
        }

    }
}
