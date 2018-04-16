#include "artistinfo.h"


ArtistInfo::ArtistInfo(QObject *parent) : QObject(parent)
{

}

void ArtistInfo::onUpdateArtists(const MusicItemVector &list)
{
    QVector<QString> artistList;
    for (int i = 0; i < list.size(); ++i) {
        if (!artistList.contains(list.at(i).getArtist())){
            artistList.append(list.at(i).getArtist());
        }
    }

    HashCharString result;

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

    emit readyResult(result);
}
