import QtQuick 1.1
import com.nokia.meego 1.0
//http://image.maps.cit.api.here.com/mia/1.6/mapview?app_id=ujVBXnF39jmEg8h4MRwl&app_code=d1K-7I--pn5m-RK7kV0AQw&c=39.97606773596748,%20-0.05802154541015625&w=420%20&h=540
Item {
    id: picDetailsArea
    property variant picLens
    property variant picCam
    property variant picFocal
    property variant picAperture
    property variant picISO
    property variant picCategory
    property variant picUpload
    property variant picTaken
    property variant picLicense
    property variant picLongitude
    property variant picLatitude
    property variant picSpeed
//    width: 400
//    height: 600

//    width: 480
//    height: 200

    function setLocation(longitude, latitude){

        if(longitude || latitude)
            imgLocation.source = "http://image.maps.cit.api.here.com/mia/1.6/mapview?app_id=ujVBXnF39jmEg8h4MRwl&app_code=d1K-7I--pn5m-RK7kV0AQw&c="+longitude+"," + latitude+"&w=500&h=500"
        else
            imgLocation.source = ""
    }

    GroupSeparator{
        id: sepDescription
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        title: "Details"
    }
    Column{
        id: column1
        width: 240
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: sepDescription.bottom
        anchors.topMargin: 0
        Label{
            id: labelCam
            text: "Camera : <b>" + picCam + "</b>"
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 20
            }
        }
        Label{
            id: labelLens
            text: "Lens : " + picLens
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 20
            }
        }
        Label{
            id: labelFocal
            text: "Focal : " +picFocal
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 20
            }
        }
        Label{
            id: labelAperture
            text: "Aperture : " +picAperture
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 20
            }
        }
        Label{
            id: labelISO
            text: "ISO : " +picISO
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 20
            }
        }
        Label{
            id: labelSpeed
            text: "Speed : " +picSpeed
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 20
            }
        }
        Label{
            id: labelCategory
            text: "Category : " +picCategory
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 20
            }
        }
//        Label{
//            id: labelUpload
//            text: "Uploads : " +picUpload
//            platformStyle: LabelStyle {
//                fontFamily: "Nokia Pure Text Light"
//                fontPixelSize: 20
//            }
//        }
    }
    Image {
        id: imgLocation
        fillMode: Image.PreserveAspectFit
        anchors.left: column1.right
        anchors.leftMargin: 10
        anchors.top: sepDescription.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        height: parent.height
    }
}
