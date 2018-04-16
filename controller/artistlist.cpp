#include "artistlist.h"
#include <QDebug>

ArtistList::ArtistList(QObject *parent) : QObject(parent)
{

}

QVector<ArtistItem> ArtistList::items() const
{
    return mList;
}

void ArtistList::setTool(ArtistInfo *tool)
{
    tool->moveToThread(&thread);
    connect(this, SIGNAL(updateArtists(MusicItemVector)), tool, SLOT(onUpdateArtists(MusicItemVector)), Qt::QueuedConnection);
    connect(tool, SIGNAL(readyResult(HashCharString)), this, SLOT(onReceiveArtists(HashCharString)), Qt::QueuedConnection);
    thread.start();
}

void ArtistList::onReceiveMediaList(const QVector<MusicItem> &list)
{
    emit preItemClear();
    mList.clear();
    emit postItemClear();

    emit updateArtists((MusicItemVector) list);
}

void ArtistList::onReceiveArtists(const HashCharString &hash)
{
    for (int i = 0; i < hash.size(); ++i) {
        emit preItemAppended();

        ArtistItem item;
        item.setGroupName(hash.keys().at(i));
        item.setArtistList(hash.values().at(i));
        mList.append(item);

        emit postItemAppended();
    }
}
