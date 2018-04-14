#include "musicitem.h"

MusicItem::MusicItem()
{

}

QString MusicItem::getUrl() const
{
    return url;
}

void MusicItem::setUrl(const QString &value)
{
    url = value;
}

QString MusicItem::getTitle() const
{
    return title;
}

void MusicItem::setTitle(const QString &value)
{
    if (value.compare("") == 0) title = "Unknown Title";
    else title = value;
}

QString MusicItem::getArtist() const
{
    return artist;
}

void MusicItem::setArtist(const QString &value)
{
    if (value.compare("") == 0) artist = "Unknown Artist";
    else artist = value;
}

QString MusicItem::getAlbum() const
{
    return album;
}

void MusicItem::setAlbum(const QString &value)
{
    if (value.compare("") == 0) album = "Unknown Album";
    else album = value;
}

QString MusicItem::getGenre() const
{
    return genre;
}

void MusicItem::setGenre(const QString &value)
{
    if (value.compare("") == 0) genre = "Unknown Genre";
    else genre = value;
}

int MusicItem::getLength() const
{
    return length;
}

void MusicItem::setLength(int value)
{
    length = value;
}
