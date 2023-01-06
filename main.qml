import QtQuick 2.11
import QtQuick.Window 2.11


Window {
    id: root

    property string videoPath: "file:///mnt/8A70CD2770CD1AB9/Main/Entertainment/Series/Modern Family/Modern.Family.S08/Modern Family S08E01 720p HDTV x265.mp4"

    visible: true
    width: 640
    height: 400
    title: qsTr("Video Player - " + videoPath)
    color: "#282828"

    FilePicker{
        width: root.width
        height: root.height

    }

//    VideoPlayer{
//        width: root.width
//        height: root.height
//        source: videoPath
//    }


}
