// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.feedback 1.1

Item{
    id: messageBoxItem
//    width: 300
    height: 140
    anchors.left: parent.left
    anchors.leftMargin: 0
    anchors.right: parent.right
    anchors.rightMargin: 0
    state: "hide"
    property string msg
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: messageBoxItem
                anchors.top: parent.top
                anchors.topMargin: 0
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: messageBoxItem
                anchors.top: parent.top
                anchors.topMargin: -140
//                anchors.left: parent.left
//                anchors.leftMargin: 0
//                anchors.right: parent.right
//                anchors.rightMargin: 0
            }
        }
    ]
    transitions: [
        Transition {
            from: "*"
            to: "*"
            PropertyAnimation{
                properties: "anchors.topMargin"
                duration: 300
//                easing.type:
            }
        }
    ]
    function show(){
        messageBoxItem.state = "show"
    }
    function hide(){
        messageBoxItem.state = "hide"
    }

    Rectangle{
        id: rectangle1
        width: parent.width
        height: 140
        color: "black"
        Label{
            id: label_msg
            height: 50
            horizontalAlignment: Text.AlignHCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            text: msg
            color: "white"
        }
        Button{
            id: btn_ok
            height: 50
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.top: label_msg.bottom
            anchors.topMargin: 20
            text: qsTr("Close")
            onClicked: {
                hide();
                hapticsEffect.running = true;
            }
        }
    }
    HapticsEffect{
        id: hapticsEffect
        attackIntensity: 0.0
        attackTime: 250
        intensity: 1.0
        duration: 100
        fadeTime: 250
        fadeIntensity: 0.0
    }

}
