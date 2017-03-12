import QtQuick 1.1
import com.nokia.meego 1.0
import "../Tools"
import "../Tools/json.js" as JS
import "../OAuth"
import "../DataBase.js" as DataBase

Page {
    id: mainPage
    tools: commonTools
    property bool loginMode: false
    function showMsgBox(msg){
        msgBox.msg = msg
        msgBox.show();
    }
    function errorLoading(){
        console.debug("ERROR LOADING")
        btn_editors.errorLoading()
        btn_fresh.errorLoading()
        btn_popular.errorLoading()
        btn_upcomming.errorLoading();
        btn_user.errorLoading();
    }
    orientationLock: PageOrientation.LockPortrait

    Component.onCompleted: {
//        DataBase.clearTable();
        login.disableBusy();
        if(loginMode){
            if(!DataBase.authentified()){
                oauth.visible = true;
                oauth.beginAuthentication();
            }
            else{
                console.debug("YES !! " + DataBase.getToken() + "  |   "+DataBase.getSecret())
                oauth.visible = false;
    //            oauth.stepThree();
                oauth.getUserData(DataBase.getToken(), DataBase.getSecret());
            }
        }
        else
        {
            oauth.visible = false;
        }
    }

    Component {
        id: galery
        Galery {
            userGalery: false
        }
    }

    Component {
        id: userGalereyComponent
        Galery {
            id: usergGalery
            userGalery: true
        }
    }
    OAuth{
        id: oauth
        anchors.fill: parent
        z:10
//        Component.onCompleted: beginAuthentication();
        onDataReady: {
            appWindow.addUser(data);
        }
        onAuthenticationCompleted: {
            oauth.visible = false;
            console.debug("Authentification complete ! ")
            showMsgBox("Authentification is completed\nWelcome home ");
        }
    }

    MessageBox{
        id: msgBox
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        height: 140
        z:10
    }

    ButtonAnimed{
        id: btn_fresh
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        width: parent.width/2
        height: 200
        z:0
        label_title: "fresh"
        Component.onCompleted: {
            JS.load("fresh");
        }
        onBtnClicked: {
            pageStack.push(galery, {type: btn_fresh.label_title, userGalery: false});
        }
    }
    ButtonAnimed{
        id: btn_popular
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        width: parent.width/2
        height: 200
        z:0
        label_title: "popular"
        Component.onCompleted: {
            JS.load("popular");
        }
        onBtnClicked: {
            pageStack.push(galery, {type: btn_popular.label_title, userGalery: false});
        }
    }
    ButtonAnimed{
        id: btn_upcomming
        anchors.top: btn_fresh.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        width: parent.width/2
        height: 200
        z:-1
        label_title: "upcoming"
        Component.onCompleted: {
            JS.load("upcoming");
        }
        onBtnClicked: {
            pageStack.push(galery, {type: btn_upcomming.label_title, userGalery: false});
        }
    }
    ButtonAnimed{
        id: btn_editors
        anchors.top: btn_popular.bottom
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        width: parent.width/2
        height: 200
        z:-1
        label_title: "editors"
        Component.onCompleted: {
            JS.load("editors");
        }
        onBtnClicked: {
            pageStack.push(galery, {type: btn_editors.label_title, userGalery: false});            
        }
    }
    ButtonAnimed{
        id: btn_user
        height: 200
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: btn_editors.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        z:-2
        label_title: "me"
        visible: loginMode
        onBtnClicked: {
            pageStack.push(galery, {type: "user", userGalery: true, userName: appWindow.getUserName()});
        }
    }
    Image {
        id: background
        fillMode: Image.PreserveAspectFit
        opacity: 0.2
        anchors.top: btn_user.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        source: "qrc:/background"
    }

    Connections{
        target: mainPage.status === PageStatus.Active ? appWindow : null
        ignoreUnknownSignals: true
        onUserNameIsReady:{
            console.debug("UserName is ready ! " + userName)
            JS.load("user", userName);
        }
    }
    onStatusChanged: {
        if(status === PageStatus.Activating)
        {
//            appWindow.menuModel.clear();
//            appWindow.menuModel.append({title: "Photos", type:"myPhotos", iconSource: "image://theme/icon-m-toolbar-add-white"});
//            appWindow.menuModel.append({title: "Photos", type:"myPhotos", iconSource: "image://theme/icon-m-toolbar-add-white"});
//            appWindow.menuModel.append({title: "Photos", type:"myPhotos", iconSource: "image://theme/icon-m-toolbar-add-white"});
//            appWindow.menuModel.append({title: "About", type:"about", iconSource: "image://theme/icon-m-toolbar-view-menu-white"});
        }
    }
}
