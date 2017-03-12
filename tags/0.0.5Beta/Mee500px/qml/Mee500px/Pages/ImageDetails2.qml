import QtQuick 1.1
import com.nokia.meego 1.0
import "../Tools"
//import "ImageLoader.js" as ImageLoader
Page {
    id: pageDetails2
//    tools: commonTools
    orientationLock: PageOrientation.Automatic

    property ListModel jsonModel
    property int indexOfModel
    function goAt(index){
        view.positionViewAtIndex(index,ListView.Beginning)
    }

    ListView {
           id: view
           anchors.fill: parent;
           model: dataModel
           orientation: ListView.Horizontal
           snapMode: ListView.SnapOneItem;
           flickDeceleration: 0
//           flickDeceleration: 500
//           cacheBuffer: width;
//           currentIndex: indexOfModel
           onMovementEnded: {
               if(atYEnd) {
                   nextPage();
               }
           }
    }


    VisualDataModel {
           id: dataModel
           model: jsonModel
           delegate: DelegateImageDetails{
               id: delegateImage
               width: view.width;
               height: view.height;
               imageURL: model.size4
               userPic: model.JSON.user.userpic_url
               userName: model.JSON.user.username
               imageName: model.JSON.name
               likes: model.JSON.votes_count
               views:model.JSON.times_viewed
               favoris: model.JSON.favorites_count
               description: model.JSON.description
               photoID: model.JSON.id
//               photoModel: model
           }
       }

}
