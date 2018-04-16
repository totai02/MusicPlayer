#include "artistitem.h"

ArtistItem::ArtistItem()
{

}

QList<QString> ArtistItem::getArtistList() const
{
    return artistList;
}

void ArtistItem::setArtistList(const QList<QString> &value)
{
    artistList = value;
}

QChar ArtistItem::getGroupName() const
{
    return groupName;
}

void ArtistItem::setGroupName(const QChar &value)
{
    groupName = value;
}
