// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.gallery 1.1
import "../DataBase.js" as DataBase
Rectangle{
    id: backgroundMenu
    color: "#111"
    anchors { top: statusBar.bottom; left: parent.left; bottom: parent.bottom; right: windowContent.left; }
    visible: windowContent.x > 0
    height: 600
    width: 300
//    property string userPicURL
//    property alias name : userName.text
    property string user
    property string userName_str
    property string fullName
    property alias jsonString: jsonModelUser.json

    function getUserName(){
        return userName_str;
    }
    function addUserMenuElements(){
        listModelMenu.append({title: "Disconnect", type:"disconnect", iconSource: "image://theme/icon-m-toolbar-close-white"});
        listModelMenu.append({title: "About", type:"about", iconSource: "image://theme/icon-m-content-description-inverse"});
//        listModelMenu.append({title: "Photos", type:"myPhotos", iconSource: "image://theme/icon-m-toolbar-add-white"});
//        listModelMenu.append({title: "About", type:"about", iconSource: "image://theme/icon-m-toolbar-view-menu-white"});
//        listModelMenu.append({title: "About", type:"about", iconSource: "image://theme/icon-m-toolbar-view-menu-white"});

        //icon path = C:\QtSDK\Simulator\Qt\mingw\harmattanthemes\blanco\meegotouch\icons
    }
    JSONListModel {
        id: jsonModelUser
        query: "user"
        comments: true
        onLoadingFinished: {
            if(typeof(jsonModelUser.model.get(0).userpic_url) === "undefined" || jsonModelUser.model.get(0).userpic_url === ""){
                userPic.source = "qrc:/defaultUserPic"
            }
            else{
                userPic.source = jsonModelUser.model.get(0).userpic_url
            }

            userPhotos.text = "Photos : " + jsonModelUser.model.get(0).photos_count
            fullName = jsonModelUser.model.get(0).fullname
            userName_str = jsonModelUser.model.get(0).username
            console.debug("Username = " + userName_str)
            userNameIsReady(userName_str);
//            userName.text = jsonModelUser.model.get(0).affection
//            Qt.openUrlExternally('http://qt.nokia.com")
//            http://qt-project.org/forums/viewthread/15922
//            menuModel.append({title: "Photos", type:"myPhotos", iconSource: "image://theme/icon-m-toolbar-add-white"});
        }

    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            window.isShowMenu = false;
            window.__title = "";
            window.__index = -1;
            window.__type = "";
        }
    }
    Rectangle{
        id:userZone
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 200
        color: "gray"
        Flipable {
//            id: flipable
            id: userPicFlipable
            property bool flipped: true
            width: 200
//            property string userPicURL
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            z:1
            front:Image {
                id: userPic
                width: 200
                fillMode: Image.PreserveAspectCrop
                sourceSize.width: 180
                anchors.fill: parent
                z:1
//                source: userPicURL
                onProgressChanged: {
                    if(progress === 1)
                        userPicFlipable.flipped = false;
                }
            }
            back:Image {
                id: userPicDefault
                width: 200
                fillMode: Image.PreserveAspectCrop
                sourceSize.width: 180
                anchors.fill: parent
                z:1
                source: "qrc:/defaultUserPic"
            }
            transform: Rotation {
                id: rotation
                origin.x: userPicFlipable.width/2
                origin.y: userPicFlipable.height/2
                axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                angle: 0    // the default angle
            }

            states: State {
                name: "back"
                PropertyChanges { target: rotation; angle: 180 }
                when: userPicFlipable.flipped
            }

            transitions: Transition {
                NumberAnimation { target: rotation; property: "angle"; duration: 300 }
            }
        }
        Rectangle{
            id: sepTop                      //Top Line
            anchors.top: parent.top
            width: parent.width
            height: 1
            color: "#2A2A2A"
        }

        Rectangle{
            id: sepBottom                      //Bottom line
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: "#2A2A2A"
        }
        Rectangle{
            id: rectUserName
            height: 30
            color: "#b3b3b3"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: userPicFlipable.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            z:0
            Label{
                id: userName
                wrapMode: Text.NoWrap
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
                font.bold: true
                text: fullName
                platformStyle: LabelStyle {
                    fontFamily: "Nokia Pure Text Light"
                    fontPixelSize: 22
                    textColor: "black"
                }
            }
        }
        Rectangle{
            id: rectView
            height: 20
            anchors.top: rectUserName.bottom
            anchors.topMargin: 5
            anchors.left: userPicFlipable.right
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            color: "transparent"
            Label{
                id: userPhotos
                anchors.fill: parent
                wrapMode: Text.NoWrap
                horizontalAlignment: Text.AlignRight

                platformStyle: LabelStyle {
                    fontFamily: "Nokia Pure Text Light"
                    fontPixelSize: 18
                }
            }
        }
    }

    ListView{
        id: listViewMenu
        anchors.top: userZone.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        model: ListModel{id:listModelMenu}
        Component.onCompleted: addUserMenuElements();       //Insert elements to listModel
        delegate: SwipeListDelegate{
            id: listDelegate
            titleWeight: Font.Light
            titleSize: 28
            width: listViewMenu.width - 5
            titleColor: "#fff"
            clip: true
            backgroundPressed: "image://theme/meegotouch-list-background-selected-center"
            onClicked: {
                window.hideMenu();
                window.__title = title;
                window.__index = index;
                window.__type = type;
            }

            Rectangle{
                anchors.top: parent.top
                width: parent.width
                height: 1
                color: "#2A2A2A"
            }

            Rectangle{
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: "#2A2A2A"
            }
        }
    }
    Connections{
//        target: mainPage.status === PageStatus.Active ? appWindow : null
        target: appWindow
        ignoreUnknownSignals: true
        onClicked:{
            if(type === "about")
                aboutDialog.open();
            else if(type === "disconnect")
                disconnectDialog.open();
        }
    }
}
