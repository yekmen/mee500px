import QtQuick 1.1
import com.nokia.meego 1.0

Item{
    property alias imageURL: img1.source
    property alias fillMode: img1.fillMode

    signal imageClicked;
    id: itemImage
    width: 120
    height: 120

    Image {
        id: img1
        anchors.fill: parent
        state: "loading"
//        source: model.image_url
//        sourceSize.height: 120
//        sourceSize.width: 120
        opacity: 0
        states: [
            State {
                name: "finished"
                when: img1.status === Image.Ready
                PropertyChanges {
                    target: img1
                    opacity: 1
                }
            },
            State {
                name: "loading"
                when: img1.status !== Image.Ready
                PropertyChanges {
                    target: img1
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
            value: img1.progress
        }
    }
    MouseArea{
        id: mouse
        anchors.fill: parent
        onClicked: {
            list.currentIndex = index;
            imageClicked();
        }
    }
    states: [
        State {
            name: "loading"
            when: img1.status != Image.Ready
            PropertyChanges {
                target: busy
                visible: true
                running: true
            }
        },
        State {
            name: "loaded"
            when: img1.status == Image.Ready || pageStack.depth > 1
            PropertyChanges {
                target: busy
                visible: false
                running: false
            }
        },
        State {
            name: "loadingImage"
            PropertyChanges {
                target: busy
                visible: true
                running: true

            }
        }
    ]
}
