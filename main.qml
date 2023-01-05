import QtQuick 2.11
import QtQuick.Window 2.11
import QtMultimedia 5.11

Window {
    id: root

    property string videoPath: "file:///mnt/8A70CD2770CD1AB9/Main/Entertainment/Series/Modern Family/Modern.Family.S08/Modern Family S08E01 720p HDTV x265.mp4"

    visible: true
    width: 640
    height: 400
    title: qsTr("Video Player - " + videoPath)
    color: "#282828"

    Video{
        id: video
        width: root.width
        height: root.height
        focus: true
        source: videoPath
        Keys.onSpacePressed: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
        Component.onCompleted: {
            console.log(root.width + "\t" + root.height)
            console.log(video.width + "\t" + video.height)
            console.log(video.availability == MediaPlayer.Available ? "Available" : "Not availabel")
        }

        Rectangle{
            id: controlsContainer
            width: parent.width
            height: parent.height/7
            anchors.bottom: parent.bottom
            gradient: Gradient {
                GradientStop { position: 0.00; color: "#00000000" }
                GradientStop { position: 0.02; color: "#03000000" }
                GradientStop { position: 0.06; color: "#0F000000" }
                GradientStop { position: 0.08; color: "#14000000" }
                GradientStop { position: 0.1; color: "#1A000000" }
                GradientStop { position: 0.3; color: "#4D000000" }
                GradientStop { position: 0.5; color: "#80000000" }
                GradientStop { position: 0.7; color: "#B3000000" }
                GradientStop { position: 0.9; color: "#CC000000" }
                GradientStop { position: 1.0; color: "#000000" }
            }

            Rectangle{
                id: libraryButton
                width: parent.width / 20
                height: width
                radius: width
                anchors.verticalCenter: controlsContainer.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.width / 25
                color: "#282828"

                Image{
                    width: parent.width / 1.5
                    height: parent.width / 1.5
                    anchors.centerIn: parent
                    source: "qrc:/images/library.svg"
                }
            }

            Rectangle{
                id: playButton
                width: parent.width / 20
                height: width
                radius: width
                anchors.centerIn: controlsContainer
                color: "#282828"

                Image{
                    anchors.fill: parent
                    source: video.playbackState == MediaPlayer.PlayingState ? "qrc:/images/pause.svg" : "qrc:/images/play.svg"
                }
            }
        }
    }
}
