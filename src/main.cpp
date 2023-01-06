#include <QGuiApplication>
#include "QDir"
#include "QtDebug"
#include <QQmlApplicationEngine>
#include "inc/videofilesmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    VideoFilesModel videoModel;

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
