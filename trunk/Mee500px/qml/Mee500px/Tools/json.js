//var popularThumbnail
//var freshThumbnail
//https://api.500px.com/v1/photos/38326040?comments&consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX&image_size=4
var urlComments;
function load(index, userName) {
    var xhr = new XMLHttpRequest();
    var key = "consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX"
    var arg = "&image_size=3&";
    var type = 0;
    var preUrl;
    var url;
    var ret;
    switch(index)
    {
    case "fresh":
        type = "fresh&";
        preUrl = "https://api.500px.com/v1/photos?feature=";
        url = preUrl + type + arg + key
        break;
    case "popular":
        type = "popular&";
        preUrl = "https://api.500px.com/v1/photos?feature=";
        url = preUrl + type + arg + key
        break;
    case "upcoming":
        type = "upcoming&";
        preUrl = "https://api.500px.com/v1/photos?feature=";
        url = preUrl + type + arg + key
        break;
    case "editors":
        type = "editors&";
        preUrl = "https://api.500px.com/v1/photos?feature=";
        url = preUrl + type + arg + key
        break;
    case "user":
        type = "user&username="+userName+"&";
        preUrl = "https://api.500px.com/v1/photos?feature=";
        url = preUrl + type + arg + key
        break;
//    case "imageDetail":
////        https://api.500px.com/v1/photos/38326040/comments?consumer_key=rKU9vjaGZ4LqgjBDv1wB3ridMUuXnQjrN4iBUEMX&image_size=4
//        preUrl = "https://api.500px.com/v1/photos/"
//        type = idImage+"?comments"
//        arg = "&image_size=4&"
//        url = preUrl + type + arg + key
//        urlComments = preUrl + idImage + "/comments" + "?" + key
//        break;
    }

    console.debug("URL = " + url)
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                ret = JSON.parse(xhr.responseText);
                if(index === "imageDetail"){
                    loadUserPage(pageStack, ret);
                }
                else
                    loadMainPage(ret, index)
            }
            else
            {
                showMsgBox("Connection error ... \nTry again !")
                errorLoading();
                console.debug("Erreur")
                ret = -1;
            }
        }
    }
    xhr.send();
    return ret;

}

function loadMainPage(ret, index){
    switch(index)
    {
    case "fresh":
        btn_fresh.imagePath = ret.photos[0].image_url;
//        btn_fresh.label_title = ret.feature;
        break;
    case "popular":
        btn_popular.imagePath = ret.photos[0].image_url;
//        btn_popular.label_title = ret.feature;
        break;
    case "upcoming":
        btn_upcomming.imagePath = ret.photos[0].image_url;
//        btn_upcomming.label_title = ret.feature;
        break;
    case "editors":
        btn_editors.imagePath = ret.photos[0].image_url;
//        btn_editors.label_title = ret.feature;
        break;
    case "user":
        btn_user.imagePath = ret.photos[0].image_url;
//        btn_user.label_title = ret.feature;
        break;
    }
}
function loadUserPage(obj , ret){
    pageStack.push(obj, {retJSON: ret, commentsLink: urlComments});
}
