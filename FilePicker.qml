import QtQuick 2.0
import Qt.labs.folderlistmodel 2.11
import QtQuick.Window 2.11
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

Window{
    id: filePickerWindow

    // User properties
    property alias folder: flModel.folder
    signal videoFileSelected(var videoFileName, var videofilePath)

    // Internal properties of the component
    property int windowSize: 600
    property var previousDirPathList: []

    maximumHeight: windowSize
    maximumWidth: windowSize
    minimumHeight: windowSize
    minimumWidth: windowSize
    title: "File Picker"
    color: "#282828"

    // Top bar displaying back button & current file path
    Rectangle{
        id: topBar
        width: parent.width
        height: parent.height * 0.07
        color: "#282828"

        // Back button
        Rectangle{
            id: backBtn
            height: parent.height / 1.5
            width: height
            radius: height
            x: 10
            anchors.verticalCenter: parent.verticalCenter
            border.width: 2
            border.color: "#d3d3d3"
            color: "transparent"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(previousDirPathList.length != 0){
                        flModel.folder = previousDirPathList[previousDirPathList.length - 1]
                        previousDirPathList.pop();
                    }
                }
            }

            Image{
                anchors.centerIn: parent
                source: "qrc:/images/back.svg"
            }
        }

        // File Path
        Rectangle{
            anchors.left: backBtn.right
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: "transparent"

            Text{
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                text: flModel.folder
                color: "#ffffff"
                elide: Text.ElideRight
            }
        }
    }

    // Text to display incase no the folder is empty
    Rectangle{
        width: parent.width - 20
        height: 60
        anchors.top: topBar.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        visible: folderList.count == 0
        radius: 5
        color: "transparent"

        Text{
            width: parent.width * 0.20
            height: implicitHeight
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            text : "Folder is empty"
            verticalAlignment: Text.AlignVCenter
            color: "#d3d3d3"
        }
    }

    // List View displaying files and folders
    ListView{
        id: folderList
        anchors.top: topBar.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        model: FolderListModel{
            id: flModel
            folder: "file://" + rootPath
            nameFilters: ["*.webm", "*.mkv", "*.flv", "*.vob", "*.ogv", "*.ogg", "*.rrc", "*.gifv", "*.mng", "*.mov", "*.avi", "*.qt", "*.wmv", "*.yuv", "*.rm", "*.asf", "*.amv", "*.mp4", "*.m4p", "*.m4v", "*.mpg", "*.mp2", "*.mpeg", "*.mpe", "*.mpv", "*.m4v", "*.svi", "*.3gp", "*.3g2", "*.mxf", "*.roq", "*.nsv", "*.flv", "*.f4v", "*.f4p", "*.f4a", "*.f4b", "*.mod"]
            showDirs: true
        }
        clip: true
        spacing: 5
        delegate: Rectangle{
            height: 60
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            radius: 5
            color: "#80d3d3d3"
            border.color: "#d3d3d3"
            border.width: 3

            // Folder/File onClicked logic
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(fileIsDir){
                        // If a folder is clicked, enter into it.
                        previousDirPathList.push(flModel.folder)    // Push the current folder into a list.
                        flModel.folder = "file://" + filePath       // Newly clicked folder path becomes the flModel's folder.
                    }
                    else{
                        // If a video file is clicked, emit the file path and close the window
                        videoFileSelected(fileName, filePath)   // Emitting the selected file's path
                        filePickerWindow.close()         // Hide once file is selected
                    }
                }
            }

            // Component displaying file icon, name and path.
            GridLayout{
                columns: 3
                rowSpacing: 20
                columnSpacing: 4
                width: parent.width
                height: parent.height

                // File Icon
                Image{
                    id: fileIcon
                    height: parent.height
                    Layout.leftMargin: 20
                    Layout.alignment: Qt.AlignVCenter
                    source: fileIsDir ? "qrc:/images/folder.svg" : "qrc:/images/video.svg"

                    ColorOverlay{
                        anchors.fill: fileIcon
                        source: fileIcon
                        color: "#282828"
                    }
                }

                // File Name
                Text{
                    Layout.preferredWidth: parent.width * 0.25
                    height: parent.height
                    text: fileName
                    Layout.alignment: Qt.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    elide: Text.ElideRight
                }

                // File Path
                Text{
                    Layout.preferredWidth: parent.width * 0.50
                    height: parent.height
                    text: filePath
                    Layout.rightMargin: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
                }
            }
        }
    }
}
