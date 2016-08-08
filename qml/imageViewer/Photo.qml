// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import IGComponents 1.0

Item{

    id: photoWrapper
    property alias source: imageInfo.source
    property alias sourceSize: originalImage.sourceSize
    property alias imageWidth: originalImage.paintedWidth
    property alias imageHeight: originalImage.paintedHeight
    property alias isWide: imageInfo.isWide
    property alias aspectRatio: imageInfo.aspectRatio
    property alias imageInfo: imageInfo
    property alias border: border
    property alias backgroundRec: backGround
    property int borderWidth: 10
//    anchors.fill: parent
    width: parent.width
    height: parent.height

    Rectangle{
        id: backGround
        color: "black"
        opacity: 0
        anchors.fill: parent

    }

    BorderImage {
        anchors {
//            fill: originalImage.status == Image.Ready ? border : placeHolder
            fill: border
            leftMargin: -6; topMargin: -6; rightMargin: -8; bottomMargin: -8
        }
        source: 'images/box-shadow.png'; smooth: true
        border.left: borderWidth; border.top: borderWidth; border.right: borderWidth; border.bottom: borderWidth
    }

    Rectangle {
        smooth: true
        id: border;
        color: 'white'
        opacity: folderView.isFullscreen? 0 : 1
        anchors.centerIn: originalImage;
//        anchors.fill: originalImage
        anchors.margins: -3
        width: originalImage.actualWidth + 6; height: originalImage.actualHeight + 6
        Rectangle{
            smooth: true
            color: 'black'
            anchors.fill: parent
            anchors.margins: 3
        }
    }
    BusyIndicator { anchors.centerIn: originalImage; on: originalImage.status != Image.Ready }

    ImageInfo{
        id: imageInfo
//        onSourceChanged: console.debug("source: " + source)
//        onImageSizeChanged:{
//            console.debug("width: " + imageSize.width)
//            console.debug("height: " + imageSize.height)
//        }
//        onAspectRatioChanged: {
//            console.debug("iWide: " + isWide)
//            console.debug("aspectRatio: " + aspectRatio)
//        }
    }

    Image {
        id: originalImage

        smooth: photoWrapper.smooth
        property int actualWidth: imageInfo.isWide?     width                               : imageInfo.aspectRatio * height
        property int actualHeight: imageInfo.isWide?    width / imageInfo.aspectRatio       : height

        width: photoWrapper.width; height: photoWrapper.height
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit;
        sourceSize.width: 100//albumDelegate.width
        cache: true
        asynchronous: true
        source: imageInfo.source
    }



}

