#ifndef VIDEOFILESMODEL_H
#define VIDEOFILESMODEL_H

#include <QObject>
#include <QAbstractItemModel>

class VideoFilesModel : public QObject
{
    Q_OBJECT
public:
    explicit VideoFilesModel(QObject *parent = nullptr);

//    QModelIndex index(int row, int col) const;
//    QModelIndex parent(const QModelIndex &child) const;
//    int rowCount(const QModelIndex &parent = QModelIndex()) const;
//    int columnCount(const QModelIndex &parent = QModelIndex()) const;
//    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;


signals:

public slots:
};

#endif // VIDEOFILESMODEL_H
