#include "albumitem.h"

AlbumItem::AlbumItem()
{

}

QString AlbumItem::getAlbumName() const
{
    return albumName;
}

void AlbumItem::setAlbumName(const QString &value)
{
    albumName = value;
}

QString AlbumItem::getArtistName() const
{
    return artistName;
}

void AlbumItem::setArtistName(const QString &value)
{
    artistName = value;
}
