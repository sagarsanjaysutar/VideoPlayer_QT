import QtQuick 2.0
import Qt.labs.folderlistmodel 2.11
import QtQuick.Controls 1.4

Item {
    id: filePickerContainer



    FolderListModel{
        id: flModel
//        nameFilters: ["*.mkv"]
        folder: "file:///home/"
        showDirs: true
        showDotAndDotDot: false

    }

    Rectangle{
        Rectangle{

        }

        Rectangle{

        }
    }

    ListView{
        id: folderList
        model: flModel
        anchors.fill: parent
        delegate: Rectangle{
            width: parent.width
            height: 30
            border.color: "#d3d3d3"
            border.width: 3

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    flModel.folder = "file://" + filePath
                }
            }

            Text{
                text: fileName
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

//    TreeView {
//        anchors.fill: parent

//        TableViewColumn {
//            title: "Name"
//            role: "fileName"
//            width: filePickerContainer.width / 2
//        }
//        TableViewColumn {
//            title: "Path"
//            role: "filePath"
//            width: filePickerContainer.width / 2
//        }

//        model: flModel
//    }

}
