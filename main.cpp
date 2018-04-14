#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "application.h"
#include "musiclistmodel.h"
#include "musicfolderlist.h"
#include "musiclist.h"
#include "musicplayer.h"
#include "musicfoldermodel.h"
#include "mediatool.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //model
    MusicListModel musicModel;
    MusicFolderModel folderModel;

    //controller
    Application application;
    MusicFolderList folderList;
    MusicList musicList;
    MediaTool mediaTool;

    application.setEngine(&engine);
    musicList.setMediaTool(&mediaTool);
    musicModel.setList(&musicList);
    folderModel.setList(&folderList);

    MusicPlayer player;

    //connect
    QObject::connect(&folderList, SIGNAL(sendFolderList(QVector<FolderItem>)), &musicList, SLOT(receiveMusicList(QVector<FolderItem>)));
    QObject::connect(&musicList, SIGNAL(getMusicList()), &folderList, SLOT(getFolderList()));
    QObject::connect(&musicList, SIGNAL(setMusicList(QVector<MusicItem>)), &player, SLOT(receivePlayList(QVector<MusicItem>)));
    QObject::connect(&player, SIGNAL(musicInfoSignal(int)), &musicList, SLOT(getMusicInfo(int)));
    QObject::connect(&musicList, SIGNAL(sendMusicInfo(MusicItem)), &player, SLOT(receiveMediaInfo(MusicItem)));
    QObject::connect(&musicList, SIGNAL(setMusicList(QVector<MusicItem>)), &application, SLOT(onShowLoading()));
    QObject::connect(&musicList, SIGNAL(loadComplete()), &application, SLOT(onHideLoading()));

    folderList.readDataFromFile();

    engine.rootContext()->setContextProperty("folderModel", &folderModel);
    engine.rootContext()->setContextProperty("musicModel", &musicModel);

    engine.rootContext()->setContextProperty("application", &application);
    engine.rootContext()->setContextProperty("musicList", &musicList);
    engine.rootContext()->setContextProperty("folderList", &folderList);
    engine.rootContext()->setContextProperty("musicPlayer", &player);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
