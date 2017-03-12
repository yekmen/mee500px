// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import "../Tools"
//https://api.500px.com/v1/photos/49677384?consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX
//Commentaire
//https://api.500px.com/v1/photos/4928401/comments?consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX
Item{
    id: delegateImage
    height: parent.height
    width: parent.width
    property variant imageURL
    property variant userPic
    property variant userName
    property variant imageName
    property variant rating
    property variant highPulse
    property variant likes
    property variant views
    property variant favoris
    property variant name
    property variant description
    property variant photoID
//    property ListModel photoModel

    function getCategorieName(value){
        var ret;
        switch(value)
        {
        case 0:
            ret = "Uncategorized";
            break;
        case 1:
            ret = "Celebrities";
            break;
        case 2:
            ret = "Film"
            break;
        case 3:
            ret = "Journalism"
            break;
        case 4:
            ret = "Nude"
            break;
        case 5:
            ret = "Black and White"
            break;
        case 6:
            ret = "Still Life"
            break;
        case 7:
            ret = "People"
            break;
        case 8:
            ret = "Landscapes"
            break;
        case 9:
            ret ="City and Architecture"
            break;
        case 10:
            ret = "Abstract"
            break;
        case 11:
            ret = "Animals"
            break;
        case 12:
            ret ="Macro"
            break;
        case 13:
            ret ="Travel"
            break;
        case 14:
            ret ="Fashion"
            break;
        case 15:
            ret ="Commercial"
            break;
        case 16:
            ret ="Concert"
            break;
        case 17:
            ret ="Sport"
            break;
        case 18:
            ret ="Nature"
            break;
        case 19:
            ret ="Performing Arts"
            break;
        case 20:
            ret ="Family"
            break;
        case 21:
            ret ="Street"
            break;
        case 22:
            ret = "Underwater"
            break;
        case 23:
            ret ="Food"
            break;
        case 24:
            ret ="Fine Art"
            break;
        case 25:
            ret ="Wedding"
            break;
        case 26:
            ret ="Transportation"
            break;
        case 27:
            ret="Urban Exploration "
            break;
        default:
            ret = "Uncategorized";
            break;
        }
        return ret;
    }


    Component.onCompleted: {
           console.debug("ID = " + photoID)
            jsonModel.source = "https://api.500px.com/v1/photos/"+photoID+"?consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX&image_size[]=1&image_size[]=2&image_size[]=3&image_size[]=4&image_size[]=5"
            jsonModelComments.source = "https://api.500px.com/v1/photos/"+photoID+"/comments?consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX"
    }
    JSONListModel {
        id: jsonModel
        query: "$.photo"
        comments: false
        photoDetails: true
        onLoadingFinished: {
        }
    }
    JSONListModel {
        id: jsonModelComments
        query: "$.comments[*]"
        comments: true
        photosLoaded: false
        onLoadingFinished: {
            console.debug("Finished to load comments")
        }
    }

    BusyIndicator{
        id: busyBackGround
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -70
        running: true
        platformStyle: BusyIndicatorStyle { size: "large" }
        z:10
    }

    ListView{
        id: viewVertical
        anchors.fill: parent
        orientation: ListView.Vertical
        snapMode: ListView.SnapOneItem;
        flickDeceleration: 200
        model: modelVertical
        delegate: imageDelegate
        boundsBehavior: Flickable.DragOverBounds
        smooth: true
//        cacheBuffer: 50
//        currentIndex: 1
//        onContentYChanged: console.debug("Y: " + contentY)
        onMovementEnded: {
            var tmpHeight = height
            var tmpIndex;
            if(contentY <= 1)        //Page 1
            {
                tmpIndex = 1;
            }
            else if(contentY > tmpHeight / 2 && contentY === tmpHeight - 1)
            {
                tmpIndex = 2;
            }
            else if(contentY > tmpHeight -1 * 2)
            {
                tmpIndex = 3;
            }
            console.debug("Changement page :" + tmpIndex)
        }
    }
    ListModel{
        id: modelVertical
//        ListElement{    //UserPage
//            viewer: false
//            comments: false
//        }
        ListElement{    //Frist page : Image
            viewer: true
            comments: false
        }
        ListElement{        //Image details
            viewer: false
            comments: false
        }
        ListElement{        //Comments
            viewer: false
            comments: true
        }
    }

    Component{
        id: imageDelegate
        Item {
//            height: 854
//            width: 480
            width: delegateImage.width
            height: delegateImage.height
            TopBar{
                id: topBar
                view: views
                fav: favoris
                like: likes
                authorName: userName
                authorPic: userPic
                picName : imageName
                visible: viewer
            }
            ZoomableImage{
                id: image
                source: imageURL
                visible: viewer
                //                    fillMode: Image.PreserveAspectFit
                anchors.fill: parent
                onProgressChanged: {
                    if(viewer)
                        if(image.progress !== 1)
                            busyBackGround.visible = true
                        else
                            busyBackGround.visible = false
                }
                onImageClicked: {
                }
            }
            ProgressBar{
                id: prgBar
                z:10
                value: image.progress
                width: 300
                visible: viewer
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                onValueChanged: {
                    if(viewer)
                        if(value === 1)
                            visible = false
                        else
                            visible = true
                }
            }
            Description{
                id: descriptionArea
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 300
                z:-1
                //                descrip: description
                visible: !viewer && !comments
                Component.onCompleted: {
                    setText(description)
                }
            }
            Rectangle{      //Clear background effect with Description list
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: descriptionArea.bottom
                visible: !viewer && !comments
//                height: 200
                anchors.bottom: parent.bottom
                color: "black"
                z:0
                PictureDetailsArea{
                    id: picDetailsArea
//                    anchors.fill: parent
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.left: parent.left
                    height: 200
                    Component.onCompleted:{
                        if(typeof(jsonModel.model.get(0)) !== "undefined")
                            setLocation(jsonModel.model.get(0).JSON.longitude, jsonModel.model.get(0).JSON.latitude)
                    }
                    picAperture: typeof(jsonModel.model.get(0)) === "undefined" ? "NC" : jsonModel.model.get(0).JSON.aperture
                    picISO: typeof(jsonModel.model.get(0))  === "undefined" ? "NC" : jsonModel.model.get(0).JSON.iso
                    picFocal: typeof(jsonModel.model.get(0))  === "undefined" ? "NC" : jsonModel.model.get(0).JSON.focal_length  + "mm"
                    picTaken: typeof(jsonModel.model.get(0))  === "undefined" ? "NC" : jsonModel.model.get(0).JSON.taken_at
                    picCam: typeof(jsonModel.model.get(0)) === "undefined" ? "NC" : jsonModel.model.get(0).JSON.camera
                    picLens: typeof(jsonModel.model.get(0)) === "undefined" ? "NC" : jsonModel.model.get(0).JSON.lens
                    picCategory: typeof(jsonModel.model.get(0)) === "undefined" ? "NC" :getCategorieName(jsonModel.model.get(0).JSON.category)
                    picSpeed: typeof(jsonModel.model.get(0)) === "undefined" ? "NC" : jsonModel.model.get(0).JSON.shutter_speed

//                    picAperture: typeof(jsonModel.model.get(0).JSON.aperture) === "undefined" ? "NC" : jsonModel.model.get(0).JSON.aperture
//                    picISO: typeof(jsonModel.model.get(0).JSON.iso)  === "undefined" ? "NC" : jsonModel.model.get(0).JSON.iso
//                    picFocal: typeof(jsonModel.model.get(0).JSON.focal_length)  === "undefined" ? "NC" : jsonModel.model.get(0).JSON.focal_length  + "mm"
//                    picTaken: typeof(jsonModel.model.get(0).JSON.taken_at)  === "undefined" ? "NC" : jsonModel.model.get(0).JSON.taken_at
//                    picCam: typeof(jsonModel.model.get(0).JSON.camera) === "undefined" ? "NC" : jsonModel.model.get(0).JSON.camera
//                    picLens: typeof(jsonModel.model.get(0).JSON.lens) === "undefined" ? "NC" : jsonModel.model.get(0).JSON.lens
//                    picCategory: getCategorieName(jsonModel.model.get(0).JSON.category)
//                    picSpeed: typeof(jsonModel.model.get(0).JSON.shutter_speed) === "undefined" ? "NC" : jsonModel.model.get(0).JSON.shutter_speed
                }
            }


            Comments{
                id: comment
                visible: comments && !viewer
                anchors.fill: parent
                modelComments: jsonModelComments.model
            }
        }
    }

}
