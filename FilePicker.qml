import QtQuick 2.0
import Qt.labs.folderlistmodel 2.11
import QtQuick.Window 2.11
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

Window{
    id: filePickerWindow

    property int windowSize: 600

    maximumHeight: windowSize
    maximumWidth: windowSize
    minimumHeight: windowSize
    minimumWidth: windowSize
    
    title: "File Picker"
    color: "#282828"
    property var previousDirPathList: [];

    signal videoFileSelected(var videofilePath)

    Rectangle{
        id: topBar
        width: parent.width
        height: parent.height * 0.07
        color: "#282828"

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

    ListView{
        id: folderList
        anchors.top: topBar.bottom
        anchors.topMargin: 10
        model: FolderListModel{
            id: flModel
            folder: "file://" + rootPath
            nameFilters: ["*.webm", "*.mkv", "*.flv", "*.vob", "*.ogv", "*.ogg", "*.rrc", "*.gifv", "*.mng", "*.mov", "*.avi", "*.qt", "*.wmv", "*.yuv", "*.rm", "*.asf", "*.amv", "*.mp4", "*.m4p", "*.m4v", "*.mpg", "*.mp2", "*.mpeg", "*.mpe", "*.mpv", "*.m4v", "*.svi", "*.3gp", "*.3g2", "*.mxf", "*.roq", "*.nsv", "*.flv", "*.f4v", "*.f4p", "*.f4a", "*.f4b", "*.mod"]
            showDirs: true
        }
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        clip: true
        spacing: 5
        delegate: Rectangle{
            width: parent.width - 20
            height: 60
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 5
            color: "#80d3d3d3"
            border.color: "#d3d3d3"
            border.width: 3

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(fileIsDir){
                        previousDirPathList.push(flModel.folder)
                        flModel.folder = "file://" + filePath
                    }
                    else{
                        videoFileSelected(filePath)
                        filePickerWindow.visibility = 0
                    }
                }
            }

            GridLayout{
                columns: 3
                rowSpacing: 20
                columnSpacing: 4
                width: parent.width
                height: parent.height

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

                Text{
                    Layout.preferredWidth: parent.width * 0.25
                    height: parent.height
                    text: fileName
                    Layout.alignment: Qt.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    elide: Text.ElideRight
                }

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
