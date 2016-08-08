// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item{
    id: photoWrapper


    Keys.forwardTo: fullscreenList
    function toggleFullScreen(){

                                                        console.debug("image clicked")
                    //albumGrid.currentIndex = 1 //solved first item jumb to last issue !!!!!!!!!!!
                    albumGrid.currentIndex = index
        fullscreenList.positionViewAtIndex(index, ListView.Contain)

                            folderView.isFullscreen ^= 1
    }

    Photo{
        id: photo
//        source: fsPath
        source: isFolder? "images/Folder-icon.png": (fsPath)? fsPath:""

    }


    MouseArea{
        z: 100
        anchors.fill: parent


        onClicked:{
            toggleFullScreen();
        }
    }

    Keys.onReturnPressed: {
//        console.debug("return pressed, index: " + index);
        toggleFullScreen();

    }
    Keys.onEscapePressed: {

        if(folderView.isFullscreen)
            toggleFullScreen()
        else event.accepted = false
    }


    states: [
        State {
            name: "fullscreen"
            when: folderView.isFullscreen
            ParentChange {
                target: photoWrapper; parent: fullscreenDelegate; x: 0; y: 0;
                width: fullscreenDelegate.width; height: fullscreenDelegate.height
            }
//            //PropertyChanges {target: imageBackground; anchors.margins: 0}
            PropertyChanges { target: photo.backgroundRec; opacity: 1 }
//            PropertyChanges { target: backButton; opacity: 0 }
//            PropertyChanges {target: albumGrid; interactive:false}
//            PropertyChanges {target: fullscreenList; focus: true}
        }
    ]
    transitions: [
        Transition {
            from: ""; to:"fullscreen"
            SequentialAnimation{

                PauseAnimation { duration: albumDelegate.GridView.isCurrentItem ? 0 : 300 }
                ScriptAction{
                    script:{
                        //photo.sourceSize.width = fullscreenList.width
                        photo.sourceSize = photo.imageInfo.imageSizeToFitInRec(fullscreenList.width, fullscreenList.height)
//                        backButton.visible = false
                        if(albumGrid.currentItem)albumGrid.currentItem.z++
                    }
                }
                ParentAnimation {
                    target: photoWrapper; //via: foreground
                    NumberAnimation {
                        //targets: [ photoWrapper, border ]
                        target: photoWrapper
                        properties: 'x,y,width,height'
                        easing.type: 'OutQuart'
                        duration: albumDelegate.GridView.isCurrentItem ? 300 : 1;
                    }
                }
                ScriptAction{script: if(albumGrid.currentItem)albumGrid.currentItem.z--}
            }
            NumberAnimation { target: photo.backgroundRec; property: "opacity"; }
        },
        Transition {
            from: "fullscreen"; to:""
            SequentialAnimation{
                        ScriptAction{script: if(albumGrid.currentItem)albumGrid.currentItem.z++}
                ParentAnimation {
                    target: photoWrapper;// via: foreground
                    NumberAnimation {
                        //                            targets: [ photoWrapper, border ]
                        target: photoWrapper
                        properties: 'x,y,width,height'
                        easing.type: 'OutQuart'
                        duration: albumDelegate.GridView.isCurrentItem ? 600 : 1;
                    }
                }
                ScriptAction{
                    script:{
//                                    photo.sourceSize.width = photo.imageWidth
                        photo.sourceSize.width = photo.imageInfo.imageSizeToFitInRec(100, 100)
//                        backButton.visible = true
                                if(albumGrid.currentItem)albumGrid.currentItem.z--
                    }
                }
            }

            NumberAnimation { target: photo.backgroundRec; property: "opacity"; }
        }
    ]


}
