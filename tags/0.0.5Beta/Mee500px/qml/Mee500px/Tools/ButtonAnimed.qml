// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.feedback 1.1

Item{
    id: btnAnimed
    width: 200
    height: 200
    signal btnClicked;
    Timer{
       id: timer
       repeat: true
       interval: 10000
       running: true
       onTriggered: {
           if(btnAnimed.state === "bottomAnimed")
               btnAnimed.state = "topAnimed"
           else
               btnAnimed.state = "bottomAnimed"
       }
    }
    function stopAnimation(){
        timer.stop();
    }
    function restartAnimation(){
        timer.start();
    }

    function errorLoading(){
        imageAnimed.state = "error"
    }
    function startRandomAnimation(){
        var now = new Date();
        var seed = now.getSeconds();
        var num = (Math.floor(4 * Math.random(seed)));
        switch(num % 4) {
        case 0:
            btnAnimed.state = "bottomAnimed"
            break;
        case 1:
            btnAnimed.state = "topAnimed"
            break;
        case 2:
            btnAnimed.state =  "bottomAnimed"
            break;
        case 3:
            btnAnimed.state = "topAnimed"
            break;
        default:
            console.debug("Default");
            break;
        }
        timer.start()
    }
    property alias label_title: label_title.text
    property alias imagePath: imageAnimed.source
    BusyIndicator{
        id: busy
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        running: true
        platformStyle: BusyIndicatorStyle { size: "large" }
        visible: true
        ProgressBar{
            id:progressBar
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            value: imageAnimed.progress
        }
    }
    Image{
        id: imageAnimed
//        anchors.topMargin: -80
        anchors.fill: parent
        fillMode: Image.TileVertically
        cache: false
        smooth: true
        onProgressChanged: {
            if(progress == 1){
                startRandomAnimation();
//                console.debug("Progress FINI= " + progress)
            }
//            else
//                console.debug("Progress = " + progress)
        }
        states: [
            State {
                name: "loaded";
                when: imageAnimed.status == Image.Ready
                PropertyChanges {
                    target: busy
                    visible: false
                    running: false;

                }
                PropertyChanges {
                    target: imageAnimed
                    opacity: 1
                }
            },
            State {
                name: "loading"
                when: imageAnimed.status != Image.Ready
                PropertyChanges {
                    target: busy
                    visible: true;
                    running: true
                }
                PropertyChanges {
                    target: imageAnimed
                    opacity: 0
                }
            },
            State {
                name: "error"
                PropertyChanges {
                    target: imageAnimed
                    source: "qrc:/error"
                    fillMode: Image.PreserveAspectFit
                    sourceSize.height: 30
                    sourceSize.width: 30
                }
                PropertyChanges {
                    target: busy
                    visible: false;
                    running: false;
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
       MouseArea{
           id: mouse
           anchors.fill: parent
           onClicked: {
               btnClicked();
               hapticsEffect.running = true;
           }
       }
    }
    Rectangle{
        id: btnTitle
        height: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        color: "gray"
        opacity: 0.5
        Label{
            id: label_title
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 32
            }
        }
    }
    states: [
        State {
            name: "topAnimed"
//            when: (imageAnimed.anchors.topMargin == 0)
            PropertyChanges {
                target: imageAnimed
                anchors.topMargin: -80

            }
        },
        State {
            name: "bottomAnimed"
//            when: (imageAnimed.anchors.topMargin == -80)
            PropertyChanges {
                target: imageAnimed
                anchors.topMargin: 0

            }
        }
    ]
    transitions: [
        Transition {
            from: "*"
            to: "*"
            PropertyAnimation {
                id: propAnim
                properties: "anchors.topMargin, opacity"
                easing.type: Easing.InQuad
                duration: 10000
            }
        }
    ]
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

