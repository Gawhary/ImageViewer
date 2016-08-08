// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Package{
    id: delegate
    //    property bool isFolder: folderModel.isFolder(index)
    property string imagePath: isFolder? "": fsPath
    Item {
        id: albumDelegate
        Package.name: 'album'
        property variant gridView
        property variant pathView: loader.item.pathView
        property bool hasImages: false
        property int foldersCount : 0
        property bool rowBegin: index % albumGrid.itemsPerRow == 0
        property bool rowend: index % albumGrid.itemsPerRow == albumGrid.itemsPerRow -1
        property int rowNumber: Math.floor(index / albumGrid.itemsPerRow) +1
        property bool firstRow: index < albumGrid.itemsPerRow
        property bool lastRow: rowNumber == albumGrid.numberOfRows
        //        property variant pathViewState: pathView? pathView.state : undefined
        //        onPathViewStateChanged: if(pathView) pathView.state = pathViewState

        width: albumGrid.delegateWidth
        height: albumGrid.delegateHeight

        //        Rectangle{
        //            color:"black"
        //            anchors.fill: parent
        //        }

        Keys.forwardTo: loader.item


        Column{
//            spacing: -5
            anchors.fill: parent
            Loader{
                id: loader
                //            anchors.left: parent.left
                //            anchors.right: parent.right
                height: 160
                width: parent.width
                source: isFolder? "AlbumFolderDelegate.qml" : "PhotoDelegate.qml"
                //            z: isFolder? 10 : 0
            }
            Item{
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 1.5
                height: parent.height * 0.25
//                color: "transparent"
//                border.color: "red"
//                border.width: 1
                Text {
                    visible: !folderView.isFullscreen
                    text: name
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                    anchors.fill: parent
                    verticalAlignment: Text.AlignBottom
                    color: "white"
                    wrapMode: Text.Wrap
                    elide: Text.ElideRight
                    maximumLineCount: 3

                }
            }
        }

        Image {
            id: hLine
            visible: albumDelegate.rowBegin && !albumDelegate.lastRow
            source: "images/line.png"
            anchors.left: albumDelegate.left
            anchors.leftMargin: albumDelegate.width * -0.5
            width: albumGrid.width
            anchors.top: albumDelegate.bottom
            anchors.topMargin: albumDelegate.height * 0.33
            fillMode: Image.PreserveAspectFit
            sourceSize.width: width
            sourceSize.height: width
            //        asynchronous: true
            cache: true

        }

    }

    Item{
        id: imageGridDelegate
        Package.name: 'browser'

        z: 90
    }

    Item{
        id: fullscreenDelegate
        property bool model_isFolder: isFolder
        Package.name: 'fullscreen'
        width: folderView.width
        height: folderView.height
        z: ListView.isCurrentItem? 100 : 90

        //        Keys.forwardTo: children.count > 0? children[0] : []
        Keys.forwardTo: albumDelegate

    }
}
