#include "musiclist.h"
#include <QDebug>

using namespace std;

MusicList::MusicList(QObject *parent) : QObject(parent)
{

}

int MusicList::count()
{
    return mList.size();
}

void MusicList::removeAll()
{

    emit preRemoveAllItem();
    mList.clear();
    emit postRemoveAllItem();
}

void MusicList::receiveMusicList(const QVector<FolderItem> &list)
{
    removeAll();
    emit setMusicList(mList);

    waitingMediaTool = list.size();

    if (waitingMediaTool == 0) {
        emit loadComplete();
        emit emptyToShow();
    }
    for(int i = 0; i < list.size(); i++){
        string folder = list.at(i).getUrl().toStdString();
        emit getDataFromMediaTool(QString::fromStdString(folder));
    }
}

void MusicList::getMusicInfo(int index)
{
    emit sendMusicInfo(mList.at(index));
}

QVector<MusicItem> MusicList::items() const
{
    return mList;
}

QJsonObject MusicList::getMediaInfo(const QJsonObject &obj)
{
    QJsonObject media = obj["media"].toObject();
    QJsonArray track = media["track"].toArray();
    QJsonObject general = track.at(0).toObject();

    return general;
}

void MusicList::setMediaTool(MediaTool *tool)
{
    tool->moveToThread(&thread);
    connect(this, SIGNAL(getDataFromMediaTool(QString)), tool, SLOT(getMediaArray(QString)));
    connect(tool, SIGNAL(resultReady(QJsonArray)), this, SLOT(receiveDataFromMediaTool(QJsonArray)));
    thread.start();
}

void MusicList::getFullDataFromTool()
{
    emit setMusicList(mList);
    emit loadComplete(mList.size());
}

void MusicList::receiveDataFromMediaTool(const QJsonArray &arrayInfo)
{
    for(int j = 0;j < arrayInfo.size();j++){

        QJsonObject info = getMediaInfo(arrayInfo.at(j).toObject());
        MusicItem item;

        item.setUrl(arrayInfo.at(j)["media"].toObject()["@ref"].toString());
        item.setTitle(info["Title"].toString());
        item.setArtist(info["Performer"].toString());
        item.setAlbum(info["Album"].toString());
        item.setGenre(info["Genre"].toString());
        item.setLength(round(info["Duration"].toString().toDouble()));

        emit preAppendItem();
        mList.append(item);
        emit postAppendItem();
    }

    waitingMediaTool--;
    if (waitingMediaTool == 0) getFullDataFromTool();
}

