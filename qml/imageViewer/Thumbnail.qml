// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle{
    property alias source: image.source
    radius: 5
    anchors.fill: parent
    Rectangle{
        anchors.fill: parent
        anchors.margins: 5
        color: "#22000000"
        Image {
            id: image
            anchors.fill: parent
            sourceSize.width: width
            sourceSize.height: height
            asynchronous: true

        }
    }
    BusyIndicator { anchors.centerIn: parent; on: image.status != Image.Ready }
}
