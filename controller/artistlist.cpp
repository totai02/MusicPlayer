#include "artistlist.h"

ArtistList::ArtistList(QObject *parent) : QObject(parent)
{

}

QVector<ArtistItem> ArtistList::items() const
{
    return mList;
}

void ArtistList::onReceiveMediaList(const QVector<MusicItem> &list)
{
    emit preItemClear();
    mList.clear();
    emit postItemClear();

    QVector<QString> artistList;
    for (int i = 0; i < list.size(); ++i) {
        if (!artistList.contains(list.at(i).getArtist())){
            artistList.append(list.at(i).getArtist());
        }
    }

    QHash<QChar, QList<QString>> result;

    for (int i = 0; i < artistList.size(); ++i) {
        QChar character = artistList.at(i).simplified().at(0);
        if (!result.contains(character)){
            QList<QString> artists;
            artists.append(artistList.at(i));
            result.insert(character, artists);
        } else {
            QList<QString> artists = result.value(character);
            artists.append(artistList.at(i));
            result.insert(character, artists);
        }
    }

    QList<QChar> keys = result.keys();
    QList<QList<QString>> values = result.values();

    for (int i = 0; i < result.size(); ++i) {
        emit preItemAppended();

        ArtistItem item;
        item.setGroupName(keys.at(i));
        item.setArtistList(values.at(i));
        mList.append(item);

        emit postItemAppended();
    }
}
