#ifndef VIDEOFILESMODEL_H
#define VIDEOFILESMODEL_H

#include <QObject>

class VideoFilesModel : public QObject
{
    Q_OBJECT
public:
    explicit VideoFilesModel(QObject *parent = nullptr);

signals:

public slots:
};

#endif // VIDEOFILESMODEL_H