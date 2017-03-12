/* JSONListModel - a QML ListModel with JSON and JSONPath support
 *
 * Copyright (c) 2012 Romain Pokrzywka (KDAB) (romain@kdab.com)
 * Licensed under the MIT licence (http://opensource.org/licenses/mit-license.php)
 */

import QtQuick 1.1
import "jsonpath.js" as JSONPath

Item {
    property string source: ""
    property string json: ""
    property string query: ""
    property bool comments: false
    property ListModel model : ListModel { id: jsonModel }
    property alias count: jsonModel.count
    property bool finished: false
    property bool photoDetails: false
    property bool photosLoaded: false
    signal loadingFinished();
    onSourceChanged: {
        console.debug("Source changed : " + source)
        finished = false
        var xhr = new XMLHttpRequest;
        xhr.open("GET", source);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE)
                json = xhr.responseText;
        }
        xhr.send();
    }

    onJsonChanged: updateJSONModel()
    onQueryChanged: updateJSONModel()

    function updateJSONModel() {
//        jsonModel.clear();
        finished = false
        if ( json === "" )
            return;

        var objectArray = parseJSONString(json, query);

        for ( var key in objectArray ) {
            var jo = objectArray[key];
            if(!comments){
                var imageURL1;
                var imageURL4;

                var totalPage;
                var currentPage;
                var totalItems;                
                for (var p in jo) {
                    if (jo.hasOwnProperty(p)) {
//                        console.debug(p)
                        if(p === "current_page"){
                            currentPage = jo[p];
                            console.debug("---------- Current page : " +currentPage)
                            //                            jsonModel.append(jo);
                        }
                        if(p === "total_pages"){
                            totalPage = jo[p];
                            console.debug("---------- totalPage page : " +totalPage)
                            //                            jsonModel.append(jo);
                        }
                        if(p === "total_items"){
                            totalItems = jo[p];
                            console.debug("---------- totalItems page : " +totalItems)
                            //                            jsonModel.append(jo);
                        }
                        if(p === "photos" && !photosLoaded){
                            photosLoaded = true;
                            console.debug("Load photos !")
                            var query2 = "$.photos[*]"
//                            var jo2;
                            var objectArray2 = parseJSONString(json, query2);
                            for ( var key2 in objectArray2 ) {
                                var jo2 = objectArray2[key2];
                                imageURL1 = objectArray2[key2].image_url[0];
                                imageURL4 = objectArray2[key2].image_url[3];
                                jsonModel.append({"size1": imageURL1,"size4": imageURL4, "JSON":jo2, "current_page": currentPage, "total_pages": totalPage, "total_items": totalItems})
                            }
                        }
                        if(photoDetails){   //Photo details
                            jsonModel.append({"JSON":jo})
                        }
                    }
                }
            }
            else
                jsonModel.append(jo)
        }
        finished = true;
        photosLoaded = false;
        loadingFinished();
    }

    function parseJSONString(jsonString, jsonPathQuery) {
        var objectArray = JSON.parse(jsonString);
        if ( jsonPathQuery !== "" )
            objectArray = JSONPath.jsonPath(objectArray, jsonPathQuery);

        return objectArray;
    }
}
