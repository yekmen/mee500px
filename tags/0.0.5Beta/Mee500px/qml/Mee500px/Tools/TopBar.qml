// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle{
    id: topRect
    property variant view
    property variant fav
    property variant like

    property variant authorPic
    property variant authorName
    property variant picName
    property alias state: topRect.state
    width: 400
//    width: 480
    function hide(){
        topRect.state = "hide"
    }
    function show(){
        topRect.state = "show"
    }

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 100
    color: "#383838"
    gradient: Gradient {
        GradientStop {
            position: 0.48;
            color: "#383838";
        }
        GradientStop {
            position: 1.00;
            color: "#000000";
        }
    }
    z:10
    state: "hide"
    Label{
        id: nameOfPicture
        height: 85
        text: picName
        wrapMode:Text.WordWrap
        anchors.right: nbView.left
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        platformStyle: LabelStyle {
            fontFamily: "Nokia Pure Text Light"
            fontPixelSize: 32
        }
        Component.onCompleted: {
            if (picName.paintedWidth > 200)
            {
                font.pixelSize = 30
            }
            else {
//                height = picName.paintedHeight
                font.pixelSize = 20
            }
        }
    }
    Label{
        id: author
        text:"by "+ authorName
        wrapMode: Text.WrapAnywhere
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        opacity: 0.5
        platformStyle: LabelStyle {
            fontFamily: "Nokia Pure Text Light"
            fontPixelSize: 20
        }
    }
    Image {
        id: userPicture
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom
        fillMode: Image.PreserveAspectCrop
        source: authorPic ? authorPic : ""
//                     jsonModel1.finished ? 1 : 0.5
        width: 95
    }
    Label{
        id: nbView
        width: 100
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: userPicture.left
        anchors.rightMargin: 10
        text: "view: " + view + "\n" +"likes: " + like + "\n" + "fav: " + fav + "\n"
        opacity:  0.6
        platformStyle: LabelStyle {
            fontFamily: "Nokia Pure Text Light"
            fontPixelSize: 20
        }
    }

    states: [
        State {
            name: "hide"
            PropertyChanges {
                target: topRect
                anchors.topMargin: -topRect.height
            }
        },
        State{
            name: "show"
            PropertyChanges {
                target: topRect
                anchors.topMargin: 0
            }
        }
    ]
    transitions: [
        Transition {
            from: "*"
            to: "*"
            PropertyAnimation{
                target:topRect
                properties: "anchors.topMargin"
                duration: 200
            }
        }
    ]
}
