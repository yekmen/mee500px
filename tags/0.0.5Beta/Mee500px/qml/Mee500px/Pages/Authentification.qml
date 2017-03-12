import QtQuick 1.1
import com.nokia.meego 1.0
import "../Tools"
import "../Tools/json.js" as JS
import "../OAuth"
import "../DataBase.js" as DataBase

Page {
    id: firstPage
    tools: commonTools
    signal guestMode;
    signal loginMode;
    function activeBusy(){
        busy.running = true;
        busy.visible = true;
    }
    function disableBusy(){
        busy.running = false;
        busy.visible = false;
    }

    Image {
        id: image
        width: 200
        height: 200
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20
        source: "qrc:/icon256"
    }
    Label{
        id: labelLogin
        width: 400
        height: 50
        text: "Welcome to Mee500px"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: image.bottom
        anchors.topMargin: 10
        platformStyle: LabelStyle {
            fontFamily: "Nokia Pure Text Light"
            fontPixelSize: 32
        }
    }
    Label{
        id: labelVersion
        width: 100
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        text: "v"+appVersion
        platformStyle: LabelStyle {
            fontFamily: "Nokia Pure Text Light"
            fontPixelSize: 20
        }
    }

    FlatButton{
        id: buttonGuest
        height: 50
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: labelLogin.bottom
        anchors.topMargin: 50
        buttonText: "Guest"
        onButtonClicked: {
            console.debug("Guest mode")
            activeBusy();
            guestMode()
        }
    }
    FlatButton{
        id: buttonLogin
        height: 50
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: buttonGuest.bottom
        anchors.topMargin: 20

        buttonText: "Login"
        onButtonClicked: {
            console.debug("Login mode")
            activeBusy();
            loginMode();
        }
    }

    BusyIndicator{
        id: busy
        platformStyle: BusyIndicatorStyle { size: "large" }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        running: false
        visible: false
        z:10
    }
}
