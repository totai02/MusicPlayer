#include "albumlist.h"

AlbumList::AlbumList(QObject *parent) : QObject(parent)
{

}

QVector<AlbumItem> AlbumList::items() const
{
    return mList;
}

void AlbumList::onReceiveMediaList(const QVector<MusicItem> &list)
{
    emit preItemClear();
    mList.clear();
    emit postItemClear();

    QHash<QString, QString> map;

    for (int i = 0; i < list.size(); ++i) {
        if (!map.contains(list.at(i).getAlbum())){
            map.insert(list.at(i).getAlbum(), list.at(i).getArtist());
        }
    }

    for (int i = 0; i < map.size(); ++i) {
        emit preItemAppended();

        AlbumItem item;
        item.setAlbumName(map.keys().at(i));
        item.setArtistName(map.values().at(i));
        mList.append(item);

        emit postItemAppended();
    }
}
