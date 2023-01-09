#include "inc/videofilesmodel.h"
#include "QDir"
#include "QtDebug"
#include <QDirIterator>

VideoFilesModel::VideoFilesModel(QObject *parent) : QObject(parent)
{
    QString rootPathStr = QDir::rootPath();   

    QDir homeDir(rootPathStr);
    QDirIterator dirItr(rootPathStr, {".mp4"}, QDir::Files);

}

//QVariant VideoFilesModel::data(const QModelIndex &index, int role) const{

//    return QVariant();
//}
