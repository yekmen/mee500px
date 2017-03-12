// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Item {
//    width: 400
//    height: 62
    property string buttonText
    signal buttonClicked;
    Rectangle{
        id: rectMain
        anchors.fill: parent
        border.color: "gray"
        border.width: 1
        color: "transparent"
        Label{
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            text: buttonText
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 25
            }
        }
        MouseArea{
            id: mouse
            anchors.fill: parent
            onClicked: {
                buttonClicked();
            }
        }
    }
}
