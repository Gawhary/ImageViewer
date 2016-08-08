// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Package{
    id: root
//    property bool isFolder: imageModel.isFolder(index)


    Item{
        id:stack
        Package.name: "stack"
        width: 160//albumGrid.delegateWidth
        height: 160//albumGrid.delegateHeight
        z: stack.PathView.z

        Item{
            id: wrapper


            visible: !isFolder
            property double randomAngle: Math.random() * 31.0 - 15.0
            //            anchors.fill: parent
            width: 160//albumGrid.delegateWidth
            height: 160//albumGrid.delegateHeight
            rotation: isFolder? 0 : randomAngle
            z: stack.PathView.z
//            opacity: isFolder? 0 : 1
//            visible: !isFolder

            //            Thumbnail{

            Loader{
                id: photoLoader
                width: parent.width
                height: parent.height
                sourceComponent: /*isFolder? folderImageComponent :*/ photoComponent
            }

//            Component{
//                id: folderImageComponent
//                Image {
//                    id: folderImage
//                    source: "images/Folder-icon.png"
//                    fillMode: Image.PreserveAspectFit
////                    width: parent.width
////                    height: parent.height
////                    visible: !albumDelegate.hasImages
////                    opacity: 0
//                }
//            }

            Component{
                id: photoComponent
                Photo{
                    id: photo
                    sourceSize.width: index < albumDelegate.foldersCount+5  ? 100: 15 //may enhance perfomance
//                    source: isFolder? "images/Folder-icon.png": (fsPath)? fsPath:""
                    source: isFolder? "": (fsPath)? fsPath:""
                    smooth: true
//                    Text {
//                        text: index
//                        anchors.centerIn: parent
//                        font.pixelSize: 20
//                        color: "red"

//                    }
                }
            }


            Component.onCompleted: {

                if(isFolder)
                    albumDelegate.foldersCount ++;
                else
                    albumDelegate.hasImages = true


//                console.debug(albumDelegate.foldersCount)
            }


            states: [
                State {
                    name: "inGrid"
                    when: pathView.state == 'spread'
                    ParentChange {
                        target: wrapper
                        parent: grid
                        x:0
                        y:0
                        rotation: 0

                    }
                    PropertyChanges {
                        target: wrapper
                        opacity: 1
                    }
                }
                ,State {
                    name: "open"
                    extend: "inGrid"
                    when: pathView.state == "open"
                }
            ]
            transitions: [
                Transition {
                    from: ""
                    to: "inGrid"
                    SequentialAnimation{

                        ParentAnimation {
                            target: wrapper
//                            via: foreground
                            //                            SequentialAnimation{
                            //                                PauseAnimation { duration: 30 * index }
                            NumberAnimation {target: wrapper; properties: 'x,y,rotation'; duration: pathView.exploreDuration}
//                            NumberAnimation {target: wrapper; properties: 'x,y,rotation,opacity'; duration: pathView.exploreDuration}
                            //                            }
                        }
                        ScriptAction{
                            script: {
                                if(index == 0)  // on first element animation only
                                {
                                    pathView.onExploringFinish()
                                    //                                    //console.debug("transition from default to inGrid")
                                }
                            }
                        }
                    }
//                    NumberAnimation { target: folderImage; property: "opacity";}
                }
                ,Transition {
                    from: "open"
                    to: ""
                    //                    SequentialAnimation{
                    ParentAnimation {
                        target: wrapper
//                        via: foreground

                        //                        SequentialAnimation{
                        //                            ScriptAction{script: folderView.currentItem.z +=200}
                        //                            PauseAnimation { duration: 10 * index }
//                        NumberAnimation {target: wrapper; properties: 'x,y,rotation,opacity'; duration: pathView.collapseDuration}
                        NumberAnimation {target: wrapper; properties: 'x,y,rotation'; duration: pathView.collapseDuration}
                        //                            ScriptAction{script:{
                        ////                                    folderView.currentItem.z -=200
                        ////                                    if(index == pathView.lastItem)// after last element animation
                        ////                                        pathView.onCollectingFinish()
                        //                                }
                        //                            }

                        //                        }
                    }

//                    NumberAnimation { target: folderImage; property: "opacity";}

                }
            ]
        }


    }
    Item{
        id: grid
        Package.name: "grid"
        width: 160//albumGrid.delegateWidth
        height: 160//albumGrid.delegateHeight
        z: stack.PathView.z
    }

}
