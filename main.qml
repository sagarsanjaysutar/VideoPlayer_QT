import QtQuick 2.11
import QtQuick.Window 2.11


Window {
    id: root
    visible: true
    width: 640
    height: 400
    title: qsTr("Video Player")
    color: "#282828"

    VideoPlayer{
        id: video
        width: root.width
        height: root.height
    }
}
