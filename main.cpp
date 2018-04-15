#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>

#include "application.h"
#include "musiclistmodel.h"
#include "musicfolderlist.h"
#include "musiclist.h"
#include "musicplayer.h"
#include "musicfoldermodel.h"
#include "mediatool.h"
#include "artistlist.h"
#include "artistmodel.h"
#include "albumlist.h"
#include "albummodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //model
    MusicListModel musicModel;
    MusicFolderModel folderModel;
    ArtistModel artistModel;
    AlbumModel albumModel;

    //controller
    Application application;
    MusicFolderList folderList;
    MusicList musicList;
    ArtistList artistList;
    AlbumList albumList;
    MediaTool mediaTool;

    application.setEngine(&engine);
    musicList.setMediaTool(&mediaTool);
    musicModel.setList(&musicList);
    folderModel.setList(&folderList);
    artistModel.setList(&artistList);
    albumModel.setList(&albumList);

    MusicPlayer player;

    //connection
    QObject::connect(&folderList, SIGNAL(sendFolderList(QVector<FolderItem>)), &musicList, SLOT(receiveMusicList(QVector<FolderItem>)));
    QObject::connect(&musicList, SIGNAL(getMusicList()), &folderList, SLOT(getFolderList()));
    QObject::connect(&musicList, SIGNAL(setMusicList(QVector<MusicItem>)), &player, SLOT(receivePlayList(QVector<MusicItem>)));
    QObject::connect(&player, SIGNAL(musicInfoSignal(int)), &musicList, SLOT(getMusicInfo(int)));
    QObject::connect(&musicList, SIGNAL(sendMusicInfo(MusicItem)), &player, SLOT(receiveMediaInfo(MusicItem)));
    QObject::connect(&musicList, SIGNAL(loadComplete()), &application, SLOT(onHideLoading()));
    QObject::connect(&musicList, SIGNAL(setMusicList(QVector<MusicItem>)), &application, SLOT(onShowLoading()));
    QObject::connect(&musicList, SIGNAL(setMusicList(QVector<MusicItem>)), &artistList, SLOT(onReceiveMediaList(QVector<MusicItem>)));
    QObject::connect(&musicList, SIGNAL(setMusicList(QVector<MusicItem>)), &albumList, SLOT(onReceiveMediaList(QVector<MusicItem>)));

    folderList.readDataFromFile();

    engine.rootContext()->setContextProperty("musicPlayer", &player);
    engine.rootContext()->setContextProperty("application", &application);
    engine.rootContext()->setContextProperty("folderModel", &folderModel);
    engine.rootContext()->setContextProperty("musicModel", &musicModel);
    engine.rootContext()->setContextProperty("artistModel", &artistModel);
    engine.rootContext()->setContextProperty("albumModel", &albumModel);
    engine.rootContext()->setContextProperty("musicList", &musicList);
    engine.rootContext()->setContextProperty("folderList", &folderList);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
