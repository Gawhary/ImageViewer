// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import folderlistmodel 1.0
import IGComponents 1.0

FocusScope{
    //    color: "gray"

    id: folderView
    property variant folderModel: _folderModel
    property alias active: albumGrid.visible
    property alias currentIndex: albumGrid.currentIndex
    property alias currentItem: albumGrid.currentItem
    property variant otherFolderView: folderView
    property bool isFullscreen: false

    function up()
    {
        //        console.debug("up called.");
        albumGrid.goToParentFolder()
    }

    anchors.fill: parent

    focus: active
    onActiveChanged: {
        //        folderView.focus = active
        z = !active? 0:1
        if(active){
            imageViewer.activeFolderView = folderView
            //            console.debug("Activated.")
            //            folderView.focus = true
        }
        //        else
        //            console.debug("Deactivated.")
    }
    //    onFocusChanged: console.debug("Focus changed to: " + focus)

    //    function activate(){
    ////        console.debug("activate called")
    //        otherFolderView.z = 0
    //        folderView.z = otherFolderView.z+1
    //        otherFolderView.focus = false
    //        folderView.focus = true
    //    }

    //    Keys.onEscapePressed: up()//transfered to main

    FolderListModel {
        id: _folderModel
        folder: main.rootFolder
        rootFolder: main.rootFolder
        nameFilters: ["*.png","*.jp*g"]
        //        sortField: FolderListModel.Type
        showOnlyReadable: true
        //        onFolderChanged: showAlbumGridTimer.restart()
        //        onOnRootChanged:{console.debug("FolderListModel.onRoot changed to: " + onRoot)}
    }
    //    Timer{
    //        id: showAlbumGridTimer
    //        interval: 5
    //        onTriggered:{
    //            //console.debug("showAlbumGridTimer trigged")
    //            albumGrid.opacity = 1
    //        }
    //    }
    Model{id: xmlModel}
    //    Model{id: imageModel; query: xmlModel.query + "/item"}
    VisualDataModel{
        id: albumVisualModel
        model: folderModel
        delegate: AlbumDelegate{}
    }

    property alias folderIndexHistory: folderIndexHistoryModel
    ListModel{
        id: folderIndexHistoryModel
    }




    Item {
        id: folderViewWraper
        anchors.rightMargin: 50
        anchors.leftMargin: 50
        anchors.bottomMargin: 50
        anchors.topMargin: 50
        anchors.fill: parent



    }

    GridView {
        id: albumGrid

        property int delegateWidth: 160
        property int delegateHeight: 190
        property int itemsPerRow: Math.floor(albumGrid.width / albumGrid.cellWidth)
        property real numberOfRows: Math.ceil(count/itemsPerRow)
        //            currentIndex: -1
        anchors.centerIn: folderViewWraper
        height: folderViewWraper.height
        width: (folderViewWraper.width - (folderViewWraper.width % cellWidth))
        anchors.horizontalCenterOffset: (cellWidth - delegateWidth) /2
        cellHeight: 300
        cellWidth: 300
        keyNavigationWraps: true


        //        Rectangle{anchors.fill: parent;color: "blue";z:-1}


        model:albumVisualModel.parts.album
        interactive: !folderView.isFullscreen
        //            Behavior on opacity {NumberAnimation{}}
        boundsBehavior: Flickable.StopAtBounds
        onCurrentIndexChanged: {
            //                console.debug("albumGrid currentIndex changed: "+ currentIndex)
            //                fullscreenList.currentIndex = currentIndex
            //            albumGrid.positionViewAtIndex(currentIndex,GridView.Center)
            if(positionFullSvreenListAtIndex)
                fullscreenList.positionViewAtIndex(currentIndex, ListView.Contain)
            positionFullSvreenListAtIndex = true
        }
        property bool positionFullSvreenListAtIndex: true
        function setCurrentIndex(i){
            positionFullSvreenListAtIndex = false
            albumGrid.currentIndex = i
        }


        focus: !folderView.isFullscreen
        highlightFollowsCurrentItem: false
        highlight:
            Item{
            id: highlight
            visible: !folderView.isFullscreen
            width: albumGrid.cellWidth * 0.8;
            height: albumGrid.cellHeight * 0.8;
            x: (albumGrid.currentItem)?albumGrid.currentItem.x - (width - albumGrid.delegateWidth) / 2 : 0
            y: (albumGrid.currentItem)?albumGrid.currentItem.y - (height - albumGrid.delegateHeight) / 2 : 0
            Behavior on x { NumberAnimation{ easing.type: Easing.OutBack;duration: 150}}
            Behavior on y { NumberAnimation{ easing.type: Easing.OutBack;duration: 150}}

            Image{
                id: highlightBG
                anchors.fill: highlight
                anchors.margins: albumGrid.cellWidth * -0.09
                visible: highlight.visible
                source: "images/highlight.png"

            }


            Image {
                parent: highlight.parent
                anchors.fill: highlight
                visible: highlight.visible
                source: "images/highlight_fg.png"
                z:100
            }
        }


        property bool isWaitingForModel: false
        property bool isWaitingForState: false

        function goToParentFolder() {
            //            console.debug("goToParentFolder called.")

            if(folderModel.onRoot){
                if(main.multiDevices){
                    _folderModel.folder = ""
                    otherFolderView.folderModel.folder = ""
                    main.onDevicesLevel = true
                }
                return
            }
            if(otherFolderView.folderModel.folder != folderModel.parentFolder){
                albumGrid.isWaitingForModel = true
                otherFolderView.folderModel.folder = folderModel.parentFolder
            }
            else
                replaceFolderViewAndCollect()
        }

        function replaceFolderViewAndCollect(){

            //                if(otherFolderView.folderModel.folder != folderModel.parentFolder)
            //                    return
            //console.debug("otherFolderView.folderModel.folder: " + otherFolderView.folderModel.folder)
            active = false
            albumGrid.positionViewAtIndex(0,GridView.Beginning)//to avoid uncrear paint when return
            if(folderIndexHistory.count < 1){
                return
            }
            var i = folderIndexHistory.get(folderIndexHistory.count - 1).index
            otherFolderView.currentIndex = 1 //solvee null currentItem issue !!!!
            otherFolderView.currentIndex = i
            //console.debug("folderIndexHistory.count: " + folderIndexHistory.count)
            folderIndexHistory.remove(folderIndexHistory.count - 1)
            //console.debug("Folder Index: " + otherFolderView.currentIndex)
            if(otherFolderView.currentItem){
                //                    otherFolderView.currentItem.pathView.animateFromGridToStack()
                otherFolderView.currentItem.z +=10
                otherFolderView.currentItem.pathView.state = 'open'
                otherFolderView.active = true
                otherFolderView.currentItem.pathView.state = ''
            }
            else{
                otherFolderView.active = true
                //                console.debug("saved index: " + i)
                //                console.debug("count: " + otherFolderView.album.count)
            }
        }


        Connections{
            target: otherFolderView.folderModel
            onFolderChanged:{
                //console.debug("folder changed to: " + otherFolderView.folderModel.folder)
                if(albumGrid.isWaitingForModel){
                    timer.start()
                    albumGrid.isWaitingForModel = false
                }
            }
        }
        Timer{
            id: timer
            interval: 1
            onTriggered: albumGrid.replaceFolderViewAndCollect()

        }



    }

    Image {
        //        id: downArow
        //        visible: !albumGrid.atYEnd
        opacity: albumGrid.contentHeight - (albumGrid.contentY + albumGrid.height) > albumGrid.delegateHeight && !fullscreenList? 1:0
        source: "images/arrow.png"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20
        width: 100
        fillMode: Image.PreserveAspectFit
        Behavior on opacity {NumberAnimation{}}
    }
    Image {
        //        id: upArow
        //        visible: !albumGrid.atYEnd
        opacity: !fullscreenList && albumGrid.contentY  > albumGrid.delegateHeight - (albumGrid.cellHeight-albumGrid.delegateHeight)? 1:0


        source: "images/uparrow.png"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        width: 100
        fillMode: Image.PreserveAspectFit
        Behavior on opacity {NumberAnimation{}}
    }
    ListView{
        id: spreadAlbumHolder
        //            currentIndex: -1
        interactive: false
        anchors.fill: albumGrid
        model: albumVisualModel.parts.browser
    }

    ListView {
        id: fullscreenList;
        anchors.fill: parent
        z:9999
        focus: folderView.isFullscreen
        //        currentIndex: -1
        model: albumVisualModel.parts.fullscreen;
        orientation: Qt.Horizontal
        interactive: folderView.isFullscreen
        keyNavigationWraps: false
        onCurrentIndexChanged: {
            albumGrid.setCurrentIndex(currentIndex)
            //            albumGrid.positionViewAtIndex(currentIndex, GridView.Contain)
            if(currentItem && currentItem.model_isFolder)
                isFullscreen = false
        }
        highlightRangeMode: ListView.StrictlyEnforceRange;
        snapMode: ListView.SnapOneItem
        highlightMoveDuration: 300
    }
    //    Keys.forwardTo: isFullscreen? fullscreenList : albumGrid
}

