// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import "../Tools/json.js" as JS
import QtMobility.feedback 1.1
import "../OAuth"
import "../DataBase.js" as DataBase

import "../Tools"
//854x480
//https://api.500px.com/v1/photos/38326040?comments&consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX&image_size=4
Page {
    id: galeryPage
    tools: commonTools
    property string type
    property int page: 1
    property int totalPage: 0
    property bool userGalery: false
    property string userName: ""
    orientationLock: PageOrientation.Automatic

    onPageChanged: {
        if(totalPage === 1)
            labelPage.text= "Loading\n"
        else
            labelPage.text= "Page\n" + page + " / " + totalPage
    }

    JSONListModel {
        id: jsonModel1
        query: "$"

        onFinishedChanged: {
            totalPage = jsonModel1.model.get(0).total_pages;
            console.debug("Total page : " + totalPage)
        }
    }
    Component.onCompleted: {
        switch(type){
        case "user":
            getUserCollection();
            break;
        default:
            jsonModel1.source = "https://api.500px.com/v1/photos?feature="+type+"&consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX&image_size[]=1&image_size[]=2&image_size[]=3&image_size[]=4&image_size[]=5&rpp=100&page="+page;
            break;
        }

    }
    function getUserCollection(){
        jsonModel1.source = "https://api.500px.com/v1/photos?feature=user&username="+userName+"&consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX&image_size[]=1&image_size[]=2&image_size[]=3&image_size[]=4&image_size[]=5&rpp=100&page="+page
    }

    ImageDetails2 {
        id: imageDetails2
        jsonModel: jsonModel1.model
    }

    function random(){
        var now = new Date();
        var seed = now.getSeconds();
        var num = (Math.floor(4 * Math.random(seed)));
        var size;
        switch(num % 2) {
        case 0:
            console.debug("0: " + num % 2);
            size = 120;
            break;
        case 1:
            console.debug("1: " + num % 2);
            size = 240;
            break;
        default:
            console.debug("Default: " + num % 2);
            size = 120;
            break;
        }
        return size;
    }
    function nextPage(){
        if(totalPage > page){
            page += 1;
            jsonModel1.comments = false;
            jsonModel1.source = "https://api.500px.com/v1/photos?feature="+type+"&consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX&image_size[]=1&image_size[]=2&image_size[]=3&image_size[]=4&image_size[]=5&rpp=100&page="+page;
        }
        else
            console.debug("End of page ! " + page + " / " + totalPage)
    }

    BusyIndicator{
        id: busyBackGround
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        running: true
        platformStyle: BusyIndicatorStyle { size: "large" }
        visible: !jsonModel1.finished
        z:10
        onVisibleChanged: {
            if(visible){
                list.opacity = 0.5
            }
            else
                list.opacity = 1
        }

        Label{
            id: labelPage
            anchors.verticalCenterOffset: 90
            anchors.verticalCenter: parent.verticalCenter
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 30
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
    GridView{
        id: list
        anchors.fill: parent
        model: jsonModel1.model
//        cellHeight: 200
//        cellWidth: 200
        cellWidth: 120; cellHeight: 120
//        highlight: appHighlight
        focus: true
        clip: true
        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
        onYChanged: {
            console.debug("At end")
        }
        onMovementEnded: {
                if(atYEnd) {
                    console.log("End of list!");
                    nextPage();
                }
        }
        delegate: Component{
            ImageLoading{
                imageURL: model.size1

                onImageClicked: {
                    hapticsEffect.running = true;
                    imageDetails2.goAt(index)
                    pageStack.push(imageDetails2, {indexOfModel: index});
                }
            }
        }
    }
}
