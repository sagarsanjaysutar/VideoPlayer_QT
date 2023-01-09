import QtQuick 2.0
import QtMultimedia 5.11

Video{
    id: video
    focus: true
    autoPlay: true

    // Video control key bindings
    Keys.onSpacePressed: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
    Keys.onLeftPressed: video.seek(position - 5000)
    Keys.onRightPressed: video.seek(position + 5000)

    // Control the Slider handle as the video progresses
    onPositionChanged: {
        if(duration > 0){
            if(position == duration){
                // If end of the video is reached then reset the slider handle position
                sliderHandle.x = slider.x
            }
            else{
                // Keep updating the Slider Handle position
                var min = video.position
                var max = video.duration
                var updateValue = (((min/max) * 100) * slider.width)
                sliderHandle.x = sliderHandle.x + updateValue
            }
        }
    }

    // Control the smooth animation of slider handle.
    onPlaybackStateChanged: {
        if(video.playbackState == MediaPlayer.PausedState){
            // Stop the slider handle animation if video is paused
            sliderHandleAnimation.velocity = 0
        }else if(video.playbackState == MediaPlayer.PlayingState){
            // Default the slider handle animation velocity which makes the sliding smooth
            sliderHandleAnimation.velocity = 100
        }else{
            // Disable the  slider handle animation
            sliderHandleAnimation.velocity = -1
        }
    }

    // Bottom controls. Play/Pause, FilePicker button and Slider
    Rectangle{
        id: controlsContainer
        width: parent.width
        height: parent.height/6
        anchors.bottom: parent.bottom
        gradient: Gradient {
            // Fade background
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

        // File Picker Button
        Rectangle{
            id: libraryButton
            width: parent.width / 20
            height: width
            anchors.verticalCenter: controlsContainer.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            radius: width
            color: "#282828"

            Image{
                width: parent.width / 1.5
                height: parent.width / 1.5
                anchors.centerIn: parent
                source: "qrc:/images/library.svg"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: filePickerWindows.show()
            }

            FilePicker{
                id: filePickerWindows
                onVideoFileSelected: {
                    video.source = "file://" + videofilePath
                    root.title = videoFileName
                }
            }
        }

        // Play/Pause Button
        Rectangle{
            id: playButton
            width: parent.width / 15
            height: width
            anchors.left: libraryButton.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            radius: width
            color: "#282828"

            Image{
                anchors.fill: parent
                source: video.playbackState == MediaPlayer.PlayingState ? "qrc:/images/pause.svg" : "qrc:/images/play.svg"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
            }
        }

        // Slider
        Rectangle{
            id: slider
            height: 5
            anchors.left: playButton.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            radius: 2
            color: "#4D282828"
        }

        // Slider Handle
        Rectangle{
            id: sliderHandle
            width: 12
            height: width
            radius: width
            anchors.verticalCenter: slider.verticalCenter
            x: slider.x

            Behavior on x{
                SmoothedAnimation { id: sliderHandleAnimation;}
            }
        }
    }
}
