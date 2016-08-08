// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

XmlListModel{
    id: xmlModel
    source: "model.xml"
    query: "/rss/item"

    XmlRole { name: "title"; query: "title/string()" }
    XmlRole { name: "source"; query: "source/string()" }
}
