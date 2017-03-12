/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the QtDeclarative module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions
** contained in the Technology Preview License Agreement accompanying
** this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights.  These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
**
**
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

import Qt 4.7
import QtWebKit 1.0
import "OAuth.js" as OAuthLogic
import "../DataBase.js" as DataBase
Item{
    id: root
    width: 800
    height: 800

    property string username: 'yekmen@gmail.com'
    property string password: 'btr2002'
    property string token: ""
    property string secret:""
    property string consumerKey:""

    signal dataReady(string data);

    function beginAuthentication(){
        step = 1;
        stepOne();
    }
    signal authenticationCompleted;
    property int step: 0
    function nextStep(){
        console.debug("NEXT STEP = " + step)
        if(step == 1)
            stepOne();
//        else if(step == 2)
//            stepTwo();
        else if(step == 3)
            stepThree();
        else
            step +=1;
        return;
    }
    function stepOne(){
        console.debug("STEP ONE")
        var xhr = OAuthLogic.createOAuthHeader("POST", "https://api.500px.com/v1/oauth/request_token", [["oauth_callback","oob"]]);
        xhr.onreadystatechange = function() { 
//                    console.log(xhr.status+'\n'+xhr.getAllResponseHeaders()+'\n'+xhr.responseText+xhr.responseXML);
            if (xhr.readyState == XMLHttpRequest.DONE){
                if(xhr.status === 200){
                    var response = xhr.responseText.split('&');
//                    if(response.length != 3)
//                        return;
                    token = response[0].split('=')[1];
                    secret = response[1].split('=')[1];
                    console.debug("Step one completed ! ")
//                    console.debug("TOKEN = " + token)
//                    console.debug("Secret = " + secret)
//                    if(response[2].split('=')[1] != 'true')
//                        console.log("Error: " + response[2]);
                    step = 2;
                    webItem.url = "https://api.500px.com/v1/oauth/authorize?oauth_token="+token+"&oauth_callback=oob";
                }
                else
                    console.debug("Step one error try again ! ")
            }
        }
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("Accept-Language", "en");
        xhr.send();
    }
    function stepTwo(){
//        console.log("Step2\n");
//        webItem.evaluateJavaScript("document.getElementById(\"user_username\").value = \"" + username + "\";");
//        webItem.evaluateJavaScript("document.getElementById(\"user_password\").value = \"" + password + "\";");
//        webItem.evaluateJavaScript("document.getElementsByTagName(\"input\")[8].click;")
//        step +=1;
    }

    function stepThree(){
        console.debug("STEP 3")
        var pin = webItem.url.toString();
        var oauth_verif = pin.split('=')[2];
        console.debug("AUT VERIF = " + oauth_verif)
        var xhr = OAuthLogic.createOAuthHeader("POST", "https://api.500px.com/v1/oauth/access_token", [["oauth_verifier",oauth_verif],["oauth_callback","oob"]], {"token":token,"secret":secret});
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                if(xhr.status === 200){
                    console.debug("Login Completed !")
//                    console.log('STEP 3\n'+xhr.status+'\n'+xhr.getAllResponseHeaders()+'\n'+xhr.responseText+xhr.responseXML);
                    var response = xhr.responseText.split('&');
                    token = response[0].split('=')[1];
                    secret = response[1].split('=')[1];
                    console.debug("TOKEN = " + token)
                    console.debug("SECRET = " + secret)
                    //username = respones[3].split('=')[1];
                    step = 0;
                    authorized = true;
                    authenticationCompleted();
                    DataBase.initTable(token,secret);
                    getUserData(token, secret);     //When authentification is OK, load user data
                }
                else if(xhr.status === 401)
                    console.debug("Login FAILED")
                else
                    console.debug("Autres : " + xhr.status)
            }
        }
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("Accept-Language", "en");
        xhr.send();
    }

    function getUserData(newToken, newSecret){
        var dataOut;
        var xhr = OAuthLogic.createOAuthHeader("GET", "https://api.500px.com/v1/users", [["oauth_callback","oob"]], {"token":newToken,"secret":newSecret});
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                if(xhr.status === 200){
                    console.debug("Data OK ! ")
                    dataOut = xhr.responseText;
                    dataReady(dataOut);
                }
                else
                    console.debug("Error ... ")
//                console.log('DATA ! \n'+xhr.status+'\n'+xhr.getAllResponseHeaders()+'\n'+xhr.responseText+xhr.responseXML);
            }
        }
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("Accept-Language", "en");
        xhr.send();
    }
    function getUserCollection(userName, newToken, newSecret){
        var dataOut;
//        ,["image_size[]", "2"],[ "image_size[]", "3"],[ "image_size[]", "4"],[ "image_size[]", "5"]
        var xhr = OAuthLogic.createOAuthHeader("GET", "https://api.500px.com/v1/photos", [["oauth_callback","oob"]], {"token":newToken,"secret":newSecret},[["feature","user"],["username", userName]/*,["image_size[]", '2']*/]);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                if(xhr.status === 200){
                    console.debug("------ Data user Collection OK ! ------")
                    dataOut = xhr.responseText;
                    dataReady(dataOut);
                }
                else
                    console.debug("Error ... \n" + xhr.getAllResponseHeaders())
//                console.log('DATA ! \n'+xhr.status+'\n'+xhr.getAllResponseHeaders()+'\n'+xhr.responseText+xhr.responseXML);
            }
        }
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("Accept-Language", "en");
        xhr.send();

//collections
    }
    property bool authorized: false
    Flickable{
        id: pageFlickableContent
        width: 800
        height: 800
        contentHeight: webItem.height
        contentWidth: webItem.width
        anchors.fill: parent;

        WebView{
            id: webItem
            opacity: 1
            onLoadFinished: nextStep();
            preferredWidth: pageFlickableContent.width
            preferredHeight: pageFlickableContent.height
            onUrlChanged: console.debug("URL = " + url)
        }
    }
}
