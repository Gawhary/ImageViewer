// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

import folderlistmodel 1.0
import IGComponents 1.0

//Item{
//    id: root

Item {
    id: main
    property string rootFolder: multiDevices? "" : devicesModel.get(0).fsPath//"/home/mohammad/picsTest"
    /*readonly*/ property bool multiDevices:  devicesModel.count > 1
    property bool onDevicesLevel: multiDevices

//    onRootFolderChanged: console.debug("root folder changed to: " + rootFolder)
//    onOnDevicesLevelChanged: console.debug("OnDevicesLevel Changed to:::::::::::::::::::::::: " + onDevicesLevel)
    width: screenWidth
    height: screenHeight

    Image{
        anchors.fill: parent
        source: "images/bg.png"
    }

    //    Loader{
    //        id: loader
    //        sourceComponent: deviceView
    //        anchors.fill: parent
    //        focus: true
    //    }

    //    Component{
    //        id: imageViewerComponent



    Item{
        id: imageViewer
        visible: !main.onDevicesLevel
        property variant activeFolderView: folderView1
        property variant otherFolderView: activeFolderView.otherFolderView
        anchors.fill: parent
        focus: false // !main.onDevicesLevel

        FolderView{
            id: folderView2
            otherFolderView: folderView1
            active: false
        }
        FolderView{
            id: folderView1
            otherFolderView: folderView2
        }

    }
    //    }
    DevicesModel{
        id: devicesModel
        mediaRoot: '/media/mohammad'
    }

    PathView {

        id: pathView
        //            visible: main.onDevicesLevel
        highlightRangeMode: PathView.ApplyRange
        width: parent.width >> 1;
        height: parent.height >> 1
        anchors.centerIn: parent
        focus: main.onDevicesLevel
        visible: main.onDevicesLevel
        Keys.onLeftPressed: decrementCurrentIndex()
        Keys.onRightPressed: incrementCurrentIndex()
        //            onCurrentIndexChanged: console.debug("CurrentDevice: " + currentIndex)
        model: devicesModel
        path: Path {

            startX: pathView.width >> 1; startY: pathView.height >> 1
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathAttribute { name: "iconOpacity"; value: 1.0 }
            PathQuad { x: pathView.width >> 1; y: 0; controlX: pathView.width ; controlY:0}
            PathAttribute { name: "iconScale"; value: 0.3 }
            PathAttribute { name: "iconOpacity"; value: 0.5 }
            PathQuad { x: pathView.width >> 1; y: pathView.height  >> 1; controlX: 0; controlY: 0 }
        }

        delegate:
            Column {
            id: wrapper
            scale: PathView.iconScale
            z: scale
            opacity: PathView.iconOpacity
//            width: 160
//            height: 190
            Image {
                id: img
                anchors.horizontalCenter: parent.horizontalCenter
                width: 160; height: 160
                source: "images/device.png"
            }
            Text {
                id: nameText
                text: name
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 20
                color: wrapper.PathView.isCurrentItem ? "white" : "black"
                width: 160
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Keys.onReturnPressed: {
                main.rootFolder = fsPath
                main.onDevicesLevel = false
                folderView1.folderModel.folder = fsPath
                folderView2.folderModel.folder = fsPath
//                console.debug("root folder changed to: " + fsPath)
            }
        }

    }


    //    Component{
    //        id: deviceView
    //    }


    Image {//backButton
        id: backButton
        x: 219
        source: "images/up.png"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 30
        anchors.rightMargin: 10
        width: 130
        height: 130


        fillMode: Image.PreserveAspectFit

        visible:  !onDevicesLevel && !imageViewer.activeFolderView.isFullscreen && !(!multiDevices && imageViewer.activeFolderView.folderModel.onRoot)



        MouseArea {
            anchors.fill: backButton
            onClicked: imageViewer.activeFolderView.up();
        }
    }
    Keys.forwardTo: [main, imageViewer.activeFolderView]
    Keys.onEscapePressed:{
//        console.debug("EscapePressed......................................................")
        imageViewer.activeFolderView.up();
    }




    Item { id: foreground; anchors.fill: parent; z:100;}


}
