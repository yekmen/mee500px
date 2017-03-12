// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Component {
    Item {
        id: item
        width: 480
        anchors.right: parent.right
        anchors.left: parent.left
//        height: 100
        height: labelComments.height + 50
        Image {
            id: userImage
            width: 50

            fillMode: Image.PreserveAspectFit
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            source: model.user.userpic_url
            opacity: 0
            states: [
                State {
                    name: "finished"
                    when: userImage.status === Image.Ready
                    PropertyChanges {
                        target: userImage
                        opacity: 1
                    }
                },
                State {
                    name: "loading"
                    when: userImage.status !== Image.Ready
                    PropertyChanges {
                        target: userImage
                        opacity: 0
                    }
                }
            ]
            transitions: [
                Transition {
                    from: "*"
                    to: "*"
                    PropertyAnimation{
                        properties: "opacity"
                        duration: 100
                    }
                }
            ]
        }
        Rectangle{
            id: rectUserName
            height: 20
            color: "#808080"
            anchors.top: parent.top
            anchors.topMargin: 0
            opacity: 0.900
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: userImage.right
            anchors.leftMargin: 0
            Label{
                id: labelUserName
                text: model.user.fullname
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAnywhere
                anchors.fill: parent
                platformStyle: LabelStyle {
                    fontFamily: "Nokia Pure Text Light"
                    fontPixelSize: 20
                }
            }
        }
        Label{
            id: labelDate
            height: 20
            anchors.left: userImage.right
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            text: model.created_at
            horizontalAlignment: Text.AlignRight
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 20
            }
        }
        Label{
            id: labelComments
            anchors.left: userImage.right
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.top: rectUserName.bottom
            anchors.topMargin: 0

            text: model.body
            horizontalAlignment: Text.AlignLeft
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 20
            }
        }
    }
}
