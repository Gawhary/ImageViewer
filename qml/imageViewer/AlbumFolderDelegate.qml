// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import folderlistmodel 1.0

Item{
    id:folderDelegate
    property alias pathView: pathView
    property alias pathViewState: pathView.state
    property bool hasContent: pathView.count > 0



    function enterFolder(){

//        console.debug("enterFolder called.")
        if(folderView.isFullscreen){
            albumGrid.currentIndex = index
            folderView.isFullscreen = false
        }
////            else
        {
            if(isFolder)
                pathView.state = 'spread'
        }
    }

    anchors.fill: parent



    FolderListModel {
        id: imageModel
        folder: fsPath
        rootFolder: main.rootFolder
        nameFilters: ["*.png","*.jp*g"]
//        sortField: FolderListModel.Type
        showOnlyReadable: true
    }

    VisualDataModel{
        id: imageVisualModel
        model: isFolder? imageModel:0
        delegate: FolderImageDelegate{}
    }

    Image {
        id: folderImage
        source: hasContent? "images/foldersFolder.png" :"images/emptyFolder.png"
        fillMode: Image.PreserveAspectFit
        width: 160//parent.width
        height: 160//parent.height
        anchors.centerIn: parent
        visible: !albumDelegate.hasImages
    }

    PathView {
        id:pathView;


        property int collapseDuration: 300
        property int exploreDuration: 300
        property int lastItem : pathItemCount > 0 ? Math.min(pathItemCount, count)-1 : count-1
        //            property bool spread: false
        //            anchors.fill: parent
//        currentIndex: -1
        width: parent.width
        height: parent.height
        x: width/2
        y: height/2
//                visible: isFolder //loaded onle if(isFolder)
//                visible: albumDelegate.hasImages // removed for view close animatin of folder has no images (has folders only)
        model:  imageVisualModel.parts.stack
        //        delegate: ImageDelegate{gridView: albumDelegate.gridView}

        property string albumState: albumDelegate.state

        pathItemCount: 5
        interactive: false


        path: Path {
            PathAttribute { name: 'z'; value: 100 }
            PathLine { x: 1; y: 1 }
            PathAttribute { name: 'z'; value: 0 }
        }

        function onExploringFinish(){
            folderView.otherFolderView.active = true
            pathView.state = ""
//                    otherFolderView.activate()
//            console.debug("Exploring Finished")

        }
        function onExploringStart(){
            folderView.otherFolderView.folderModel.folder = fsPath
            folderView.otherFolderView.folderIndexHistory.append({"index":index})
//                            console.debug("Exploring starts")
            folderView.active = false
        }

        states: [State {name: "spread"}, State{name: "open";}]
        //                onStateChanged: console.debug("pathView state changed to: " + state)
        transitions: [
            Transition {
                from: ""
                to: "spread"
                ScriptAction{
                    script: {
                        if(hasContent)
                            pathView.onExploringStart()
//                        else

                    }
                }
            }
            ,
            Transition {
                from: "open"
                to: ""
                SequentialAnimation{
                    //                        NumberAnimation { target: folderView; property: "active"; duration: pathView.collapseDuration; to:1.0 }
                    PauseAnimation { duration: pathView.collapseDuration+100}
                    //                        //prepare other model for next up
                    ScriptAction{
                        script:{
//                                    folderView.activate()
                            if(otherFolderView.folder != main.rootFolder) otherFolderView.folderModel.folder = folderModel.parentFolder;
                            albumGrid.currentItem.z -= 10
                        }
                    }

                }
            }
        ]

    }
    MouseArea{
        id: stackMouseArea

        anchors.fill: parent
        onClicked: {
            enterFolder();
        }
    }
    Keys.onReturnPressed: enterFolder();

    GridView {
        id: imageGrid
//        currentIndex: -1
        parent: imageGridDelegate
        width: spreadAlbumHolder.width
        height: spreadAlbumHolder.height
        cellHeight: albumGrid.cellHeight
        cellWidth: albumGrid.cellWidth
        model: imageVisualModel.parts.grid
        interactive: false
        z: 100
        //            delegate: ImageDelegate{}
    }


    states: [
        State {
            name: "fullscreen"
            when: folderView.isFullscreen
            ParentChange {
                target: folderDelegate; parent: fullscreenDelegate;// x: 0; y: 0;
                width: fullscreenDelegate.width; height: fullscreenDelegate.height
            }
        }
    ]
//    transitions: [
//        Transition {
//            ParentAnimation{
//                target: folderDelegate;
//                NumberAnimation{target: folderDelegate; properties: 'x,y,width,height' ;duration: 1000}
//            }
//        }
//    ]
}
