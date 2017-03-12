import QtQuick 1.1
import com.nokia.meego 1.0

import "Pages"
import "Tools"
import "DataBase.js" as DataBase
import QtMobility.feedback 1.1

//PageStackWindow {
SwipePageStackWindow {
    id: appWindow
    style: PageStackWindowStyle{cornersVisible: false}

    Component.onCompleted: {
        theme.inverted = !theme.inverted
    }

    initialPage: login
    showStatusBar: false

    Component {
        id: mainPageComp
        MainPage {
        }
    }
    Authentification{
        id: login
        visible: false
        onStatusChanged: {
            if(status === PageStatus.Activating)
            {
                if(DataBase.authentified()){
                    pageStack.push(mainPageComp, {loginMode: true})
                }
            }
        }

        onGuestMode: {
            pageStack.push(mainPageComp, {loginMode: false});
        }
        onLoginMode: {
            pageStack.push(mainPageComp, {loginMode: true});
        }
    }
    QueryDialog{
        id: aboutDialog
        icon: "qrc:/icon64"
        titleText: "About Mee500px"
        message: "By Yavuz EKMEN\n"+"mail: y.ekmen@ovi.com\n"+"Version : "+appVersion +"BETA"
        acceptButtonText: "Close"
    }
    QueryDialog{
        id: disconnectDialog
        //        icon: "qrc:/icon64"
        titleText: "Disconnect"
        message: "Are you sure ?"
        acceptButtonText: "Yes"
        rejectButtonText: "No"
        onAccepted: {
            console.debug("Disconnecting accepted!")
            DataBase.clearTable();
            pageStack.pop(0);
        }
        onRejected: {
            disconnectDialog.close()
        }
    }
    ToolBarLayout {
        id: commonTools
        visible: true
        ToolIcon {
             visible: pageStack.depth > 2
             platformIconId: "toolbar-back"
             onClicked: {
                 hapticsEffect.running = true
                 pageStack.pop();
             }
         }
//        ToolIcon {
//            platformIconId: "toolbar-view-menu"
//            anchors.right: (parent === undefined) ? undefined : parent.right
//            onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open() : myMenu.close()
//        }

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
    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem { text: qsTr("Sample menu item") }
        }
    }
}
